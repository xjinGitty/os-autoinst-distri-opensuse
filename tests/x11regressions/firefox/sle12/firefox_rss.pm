# SUSE's openQA tests
#
# Copyright © 2009-2013 Bernhard M. Wiedemann
# Copyright © 2012-2016 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Case#1479557: Firefox: RSS Button

use strict;
use base "x11regressiontest";
use testapi;

sub run() {
    mouse_hide(1);

    # Clean and Start Firefox
    x11_start_program("xterm -e \"killall -9 firefox;rm -rf .moz*\"");
    x11_start_program("firefox");
    assert_screen('firefox-launch', 90);

    send_key "alt-v", 1;
    send_key "t";
    send_key "c";

    assert_and_click "firefox-rss-close_hint";
    assert_and_click "firefox-click-scrollbar";
    assert_and_click("firefox-rss-button", "right");

    send_key "a";
    send_key "ctrl-w";
    send_key "alt-f10";
    assert_screen("firefox-rss-button_disabled", 60);

    send_key "esc";
    send_key "alt-d";
    type_string "www.gnu.org\n";

    assert_and_click "firefox-rss-button_enabled", "left", 30;
    assert_screen("firefox-rss-page", 90);

    # Exit
    send_key "alt-f4";

    if (check_screen('firefox-save-and-quit', 30)) {
        # confirm "save&quit"
        send_key "ret";
    }
}
1;
# vim: set sw=4 et:
