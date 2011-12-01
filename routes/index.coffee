# GET /
exports.index = (req, res) ->
  res.render 'index.haml', { title: 'Express' }
