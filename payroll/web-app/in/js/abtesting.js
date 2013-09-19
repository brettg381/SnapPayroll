// SETUP
var abcore = {
    const : {
        APP : 'brett_test_OptimalPaycheckFlow',
        EXPERIMENT : 'brett_test_IOPLiteFirst-UseExperiments',
        UID_COOKIE_NAME : 'intuit.ems.ep.uid'
    },
    utils : {
        generateUUID : function() {
            var d = new Date().getTime();
            var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = (d + Math.random()*16)%16 | 0;
                d = Math.floor(d/16);
                return (c=='x' ? r : (r&0x7|0x8)).toString(16);
            });
            return uuid;
        },
        setCookie : function (c_name, value, exdays) {
            var exdate=new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
            document.cookie=c_name + "=" + c_value;
        },
        getCookie : function (c_name) {
            var c_value = document.cookie;
            var c_start = c_value.indexOf(" " + c_name + "=");
            if (c_start == -1) {
                c_start = c_value.indexOf(c_name + "=");
            }
            if (c_start == -1) {
                c_value = null;
            } else {
                c_start = c_value.indexOf("=", c_start) + 1;
                var c_end = c_value.indexOf(";", c_start);
                if (c_end == -1) {
                    c_end = c_value.length;
                }
                c_value = unescape(c_value.substring(c_start,c_end));
            }
            return c_value;
        },
        postImpression : function(experimentId, uid) {
            var date = new Date();
            var timestamp = date.toISOString();
            var data = {};
            data[abcore.const.APP] = [[timestamp, experimentId]];
            $.ajax({
                url: 'http://intuit.levelupanalytics.com/abntest/impressions/' + uid,
                type: 'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function(data, status, jqXHR) {
                    console.log('[ABCORE] postImpression SUCCESS!');
                },
                error: function(jqXHR, status, errorThrown) {
                    console.log('[ABCORE] ERROR response from postImpression :');
                    console.log(jqXHR);
                }
            });
        },
        postAction : function(actionStr, experimentId, uid) {
            var date = new Date();
            var timestamp = date.toISOString();
            var data = {};
            data[abcore.const.APP] = [[timestamp, experimentId, actionStr]];
            $.ajax({
                url: 'http://intuit.levelupanalytics.com/abntest/actions/' + uid,
                type: 'POST',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(data),
                success: function(data, status, jqXHR) {
                    console.log('[ABCORE] postActions SUCCESS!');
                },
                error: function(jqXHR, status, errorThrown) {
                    console.log('[ABCORE] ERROR response from postActions :');
                    console.log(jqXHR);
                }
            });
        }
    },
    uid : null,
    bucketId : null
};

// Sets the login flow to one of 3 options.
// Called after a bucket is chosen by abcore.
var setLoginFlow = function(flowName) {
    switch (flowName) {
        case 'sign-up-page':
            $('#modalLayout').toggleClass('inactive');
            $('#signupModal').show();
            $('#signupModal h1').html('Sign up and get started with paychecks!');

        case 'calculator-page':
            $('#action-layout').show();
            $('#landingLayout').hide();
            break;
        case 'landing-page':
            break;
    }
    console.log("[APP] Set login flow to '" + flowName + "'");
};

// Registers handlers that should be reported back to abcore.
// Called after page load when a flow has been determined.
var registerAbcoreActions = function() {
    $('#signupGoButton').bind('click', function() {
        console.log('[APP] sign-up button clicked with abcore action attached.');
        abcore.utils.postAction('sign-up', abcore.const.EXPERIMENT , abcore.uid);
    });
    $('#landingCalculateButton').bind('click', function() {
        console.log('[APP] landing page calculate button clicked with abcore action attached.');
        abcore.utils.postAction('landing-calculate', abcore.const.EXPERIMENT , abcore.uid);
    });
};

// This should be loaded in the page head section because these actions determine
// the rendered content on the page.

// Determine a user ID for the current user.
// For the demo, we will assume that a user ID is passed in the GET.
// But if the uid parameter is not passed, then assign them something.

// First process location.search and check for a passed in uid.
abcore.urlBindings = location.search.replace('?', '').split('&').map(function(val) {
    var binding = val.split('=');
    if (binding[0].toLowerCase() == 'uid') {
        abcore.uid = binding[1];
    }
    return binding;
});

// If uid has not been set, then we want to check for the presence of a uid cookie.
if (abcore.uid == null) {
    abcore.uid = abcore.utils.getCookie(abcore.const.UID_COOKIE_NAME);
}

// In full AB testing we assign a UID to all visitors.
// But full testing is not on by default. To bucket a user, give them a URL with a UID.
// If uid has still not been set, then we assign one based on the
//if (abcore.uid == null) {
//    abcore.uid = abcore.utils.generateUUID();
//}

// If the UID has been set then they are a participant.
// We set the UID cookie and bucket them.
if (abcore.uid != null) {
    // Store the uid in a cookie
    abcore.utils.setCookie(abcore.const.UID_COOKIE_NAME, abcore.uid, 20);

    // Ask the abcore service for the bucket ID.
    $.ajax({
        url: 'http://intuit.levelupanalytics.com/abntest/assignments/'+abcore.uid+'/brett_test_OptimalPaycheckFlow/brett_test_IOPLiteFirst-UseExperiments',
        type: 'GET',
        success: function(data, status, jqXHR) {
            abcore.bucketId = data.value.assignment;
            console.log('[ABCORE] BUCKET ASSIGNMENT = ' + abcore.bucketId);
            var flowName = '';
            switch (abcore.bucketId) {
                case 'flow_a_with_landing': flowName = 'landing-page'; break;
                case 'flow_b_direct_fill_out': flowName = 'calculator-page'; break;
                case 'flow_c_sign-up_page': flowName = 'sign-up-page'; break;
            }
            setLoginFlow(flowName);
            abcore.utils.postImpression(abcore.const.EXPERIMENT, abcore.uid);
            $(document).ready(function() {
                abcore.utils.postAction('page-load');
                registerAbcoreActions();
            });
        },
        error: function(jqXHR, status, errorThrown) {
            abcore.bucketId = 'default';
            console.log("Error when asking abcore for bucket. Bucket ID set to 'default'.");
            console.log(jqXHR);
        }
    });
}

