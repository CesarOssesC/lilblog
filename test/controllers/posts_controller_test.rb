require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:first_post)
  end

  test "should get index" do
    get posts_url
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
    assert_equal 3, Post.count
  end

  test "should get show" do
    get post_url(@post)
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get new" do
    get new_post_url
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "deberia crear un post" do
    assert_difference "Post.count", 1 do
      post posts_url, params: 
      { post: {
        title: "Otro Post",
        description: "Creando otro post de prueba"
      }}
    end
    assert_redirected_to post_url(Post.last)
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "deberia actualizar un post" do
    patch post_url(@post), params:
     { post: {
        title: "Editando Post",
        description: "Editando un post de prueba"
      }}
    @post.reload
    assert_redirected_to post_url(@post)
    assert_response :found
    assert_equal "Editando Post", @post.title
    assert_equal "Editando un post de prueba", @post.description
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "deberia eliminar un post" do
    assert_difference("Post.count", -1) do
      delete post_url(posts(:first_post))
    end
    assert_redirected_to posts_url
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end
end
