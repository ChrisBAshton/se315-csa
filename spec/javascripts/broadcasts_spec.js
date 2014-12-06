// include spec/javascripts/helpers/some_helper_file.js and app/assets/javascripts/foo.js
describe('Broadcast', function () {

    beforeEach(function () {
        // Google Chrome -> http://localhost:3000/broadcasts/new?page=1 -> copied and pasted <div class="content"> container -> minified -> pasted here as fixture data
        $('body').append('<div class="content"> <h1>New broadcast</h1><form accept-charset="UTF-8" action="/broadcasts" class="new_broadcast" id="new_broadcast" method="post"><div style="display:none"><input name="utf8" type="hidden" value="✓"><input name="authenticity_token" type="hidden" value="GDxzy9ysSGGsNBpKTHHz44CAkVe8eAF7nrT49Xr2zo0="></div><input id="page" name="page" type="hidden" value="1"> <div id="broadcast-area" class="main-input-area"> <p> <textarea autofocus="autofocus" cols="100%" id="broadcast_content" name="broadcast[content]" rows="10" title="Broadcast text goes here" style="background-color: rgb(255, 167, 167);"></textarea> </p><div id="url-part" style="display: block;"> <a href="/broadcasts/new?id=split-arrow&amp;title=Press+this+to+shorten+the+URL">Shortens URL</a> <input id="shorten_url" name="shorten_url" size="50%" title="Enter URL that you wish to shorten" type="text"> </div><br><div id=""> <input confirm="Do you really want to broadcast?" name="commit" type="submit" value="Broadcast"> | <a href="/broadcasts?page=1">Back</a> </div></div><div class="sub-input-area"> <div class="checkboxes"> <p> <input checked="checked" id="feeds_alumni_email_cs-alumni" name="feeds[alumni_email]" title="Select to broadcast general news" type="radio" value="cs-alumni"> <label for="feeds_alumni_email_alumni">General news</label> </p><p> <input id="feeds_alumni_email_cs-alumni-jobs" name="feeds[alumni_email]" title="Select to broadcast general news" type="radio" value="cs-alumni-jobs"> <label for="feeds_alumni_email_alumni-jobs">Jobs news</label> </p><p> <input checked="checked" id="feeds_email" name="feeds[email]" title="Select to choose Email feed" type="checkbox" value="1"> <label for="email">Email</label> </p><p> <input checked="checked" id="feeds_facebook" name="feeds[facebook]" title="Select to choose Facebook feed" type="checkbox" value="1"> <label for="facebook">Facebook</label> </p><p> <input checked="checked" id="feeds_RSS" name="feeds[RSS]" title="Select to choose RSS feed" type="checkbox" value="1"> <label for="RSS">RSS</label> </p><p> <input checked="checked" id="feeds_atom" name="feeds[atom]" title="Select to choose Atom feed" type="checkbox" value="1"> <label for="atom">Atom</label> </p><p> <input checked="checked" id="feeds_twitter" name="feeds[twitter]" title="Select to choose Twitter feed" type="checkbox" value="1"> <label for="twitter">Twitter</label> </p><label for="twitter" id="twitter-char-count" title="Twitter character remaining count" style="color: rgb(0, 0, 0); display: block;">96</label> </div></div></form></div>');
        Broadcast.init();
    });

    afterEach(function () {
        //$('.content').remove();
    });

    it("should change colour as the user types", function () {
        makeSureTwitterFeedIsChecked();
        expect(textFieldColor()).toBe("rgb(255, 255, 255)");
        updateTextField("Hello, world!");
        // expect(textFieldColor()).toBe("rgb(255, 229, 229)");
        //console.log('val', $('#broadcast_content').val());
    });

    function textFieldColor() {
        return $('#broadcast_content').css('background-color');
    }

    function updateTextField(text) {
        $('#broadcast_content').val(text);
        $('#broadcast_content').trigger('keyup');
    }

    function makeSureTwitterFeedIsChecked() {
        $('#feeds_twitter').prop('checked', true);
    }
});