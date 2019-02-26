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
end
