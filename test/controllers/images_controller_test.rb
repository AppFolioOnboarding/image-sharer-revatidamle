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
                 link: 'http://power.itp.ac.cn/~jmyang/funny/fun2.jpg',
                 tag_list: %w[tag1 tag2])
    Image.create(title: 'test_2',
                 link: 'http://power.itp.ac.cn/~jmyang/funny/fun3.jpg',
                 tag_list: %w[tag2 tag4])

    # Redirect to index page
    get root_url

    # Assert correct images are displayed against title in reverse order
    assert_select '.container-fluid' do
      assert_select '.card:first-child' do
        assert_select 'img[src=?]', 'http://power.itp.ac.cn/~jmyang/funny/fun3.jpg'
        assert_select '.card-body' do
          assert_select 'p.card-text' do
            assert_select 'a', 'tag2'
            assert_select 'a', 'tag4'
          end
        end
      end
      assert_select '.card:nth-child(2)' do
        assert_select 'img[src=?]', 'http://power.itp.ac.cn/~jmyang/funny/fun2.jpg'
        assert_select '.card-body' do
          assert_select 'p.card-text' do
            assert_select 'a', 'tag1'
            assert_select 'a', 'tag2'
          end
        end
      end
    end
  end

  def test__tagged_check_tag_filter
    # Save 2 rows in DB
    Image.create(title: 'test_1',
                 link: 'http://power.itp.ac.cn/~jmyang/funny/fun2.jpg',
                 tag_list: %w[tag1 tag2])
    Image.create(title: 'test_2',
                 link: 'http://power.itp.ac.cn/~jmyang/funny/fun3.jpg',
                 tag_list: %w[tag2 tag4])

    get tagged_path(tag: 'tag1')
    assert_select '.container-fluid' do
      assert_select '.card', count: 1
    end

    get tagged_path(tag: 'tag2')
    assert_select '.container-fluid' do
      assert_select '.card', count: 2
    end

    get tagged_path(tag: 'tag4')
    assert_select '.container-fluid' do
      assert_select '.card', count: 1
    end
  end
end
