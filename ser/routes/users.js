var express = require('express');
var router = express.Router();

/*
 * GET userlist.
 */
router.get('/userlist', function(req, res) {
    var db = req.db;
    var collection = db.get('userlist');
    collection.find({},{},function(e,docs){
        res.json(docs);
    });
});


// /* GET Userlist page. */
// router.get('/userlist2', function(req, res) {
//     var db = req.db;
//     var collection = db.get('usercollection');
//     collection.find({},{},function(e,docs){
//         res.render('userlist', {
//             "userlist" : docs
//         });
//     });
// });

/*
 * GET derps.
 */
router.get('/derp', function(req, res) {
    var db = req.db;
    var collection = db.get('onederp');
    collection.find({},{},function(e,docs){
        res.json(docs);
    });
});

module.exports = router;
