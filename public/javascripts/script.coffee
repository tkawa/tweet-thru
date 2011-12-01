$ ->
  items = $('#stream-items')
  socket = io.connect()
  socket.on 'tweet', (tweet) ->
    tweet_html = """
      <div class="tweet">
        <div class="tweet-image">
          <a href="http://twitter.com/#{tweet.user.screen_name}">
            <img src="#{tweet.user.profile_image_url}"/>
          </a>
        </div>
        <div class="tweet-content">
          <div class="tweet-row">
            #{tweet.user.name}
          </div>
          <div class="tweet-row">
            <div class="tweet-text">
              #{tweet.text}
            </div>
          </div>
          <time class="tweet-row">
            <a href="http://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id_str}">
              #{tweet.created_at}
            </a>
          </div>
    """
    $('<article></article>')
      .html(tweet_html)
      .prependTo items
