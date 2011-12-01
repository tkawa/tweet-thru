
  $(function() {
    var items, socket;
    items = $('#stream-items');
    socket = io.connect();
    return socket.on('tweet', function(tweet) {
      var tweet_html;
      tweet_html = "<div class=\"tweet\">\n  <div class=\"tweet-image\">\n    <a href=\"http://twitter.com/" + tweet.user.screen_name + "\">\n      <img src=\"" + tweet.user.profile_image_url + "\"/>\n    </a>\n  </div>\n  <div class=\"tweet-content\">\n    <div class=\"tweet-row\">\n      " + tweet.user.name + "\n    </div>\n    <div class=\"tweet-row\">\n      <div class=\"tweet-text\">\n        " + tweet.text + "\n      </div>\n    </div>\n    <time class=\"tweet-row\">\n      <a href=\"http://twitter.com/" + tweet.user.screen_name + "/status/" + tweet.id_str + "\">\n        " + tweet.created_at + "\n      </a>\n    </div>";
      return $('<article></article>').html(tweet_html).prependTo(items);
    });
  });
