using Gtk;

int close_timeout = 1000;

const GLib.OptionEntry[] options = {
	// --timeout INT
	{ "timeout", 0, 0, OptionArg.INT, ref close_timeout, "close timeout (default 1000 msec)", "INT" },

	// list terminator
	{ null }
};

int main (string[] args) {
    try {
	    var opt_context = new OptionContext ("- GTK cat");
    	opt_context.set_help_enabled (true);
		opt_context.add_main_entries (options, null);
		opt_context.parse (ref args);
	} catch (OptionError e) {
		print ("error: %s\n", e.message);
		print ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
		return 0;
	}

    Gtk.init (ref args);

    var window = new Window ();
    window.title = "gtkat";
    window.border_width = 0;
    window.window_position = WindowPosition.CENTER;
    window.destroy.connect (Gtk.main_quit);

    var text_view = new TextView ();
    text_view.editable = false;
    text_view.cursor_visible = false;

    text_view.buffer.text = read_file(stdin);
    text_view.set_monospace (true);
    window.add (text_view);
    window.show_all ();

    Timeout.add (close_timeout, () => {
        window.close();
        return true;
    });

    Gtk.main ();
    return 0;
}

string read_file (FileStream file) {
    var input = new StringBuilder ();
    var buffer = new char[1024];
    while (!file.eof ()) {
        string read_chunk = file.gets (buffer);
        if (read_chunk != null) {
            input.append (read_chunk);
        }
    }
    return input.str;
}
