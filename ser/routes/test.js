var express = require('express');
var router = express.Router();

/*
 * GET derps.
 */
router.get('/test', function(req, res) {
    var db = req.db;
    res.render('error', { title: 'Express' });
});

module.exports = router;
