class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_check_homepage
    get root_url
    assert_response :success
  end

  def test_create__valid_image
    assert_difference 'Image.count' do
      post images_url,
           params: { image: { title: 'test_image',
                              link: 'https://cdn.pixabay.com/photo/2013/08/22/19/18/rose-174817__340.jpg' } }
    end
    assert_redirected_to 'https://cdn.pixabay.com/photo/2013/08/22/19/18/rose-174817__340.jpg'
  end

  def test_create__invalid_image
    assert_no_difference 'Image.count' do
      post images_url,
           params: { image: { title: 'test_image',
                              link: 'ht://cdn.pixabay.com/photo/2013/08/22/19/18/rose-174817__340.jpg' } }
      assert_response :success
      assert_select '#image_title[value=?]', 'test_image'
      assert_select '#image_link', 'ht://cdn.pixabay.com/photo/2013/08/22/19/18/rose-174817__340.jpg'
    end
  end

  def test_index__check_order
    # Save 2 rows in DB
    Image.create(title: 'test_1',
                 link: 'http://power.itp.ac.cn/~jmyang/funny/fun2.jpg')
    Image.create(title: 'test_2',
                 link: 'http://power.itp.ac.cn/~jmyang/funny/fun3.jpg')

    # Redirect to index page
    get root_url

    # Assert correct images are displayed against title in reverse order
    assert_select '.image_grid' do
      assert_select '.card:first-child' do
        assert_select 'img[src=?]', 'http://power.itp.ac.cn/~jmyang/funny/fun3.jpg'
      end
      assert_select '.card:nth-child(2)' do
        assert_select 'img[src=?]', 'http://power.itp.ac.cn/~jmyang/funny/fun2.jpg'
      end
    end
  end
end
