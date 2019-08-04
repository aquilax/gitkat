using Gtk;

string read_stdin () {
    var input = new StringBuilder ();
    var buffer = new char[1024];
    while (!stdin.eof ()) {
        string read_chunk = stdin.gets (buffer);
        if (read_chunk != null) {
            input.append (read_chunk);
        }
    }
    return input.str;
}

int main (string[] args) {
    Gtk.init (ref args);

    var window = new Window ();
    window.title = "gtkat";
    window.border_width = 0;
    window.window_position = WindowPosition.CENTER;
    window.destroy.connect (Gtk.main_quit);

    var text_view = new TextView();
    text_view.editable = false;
    text_view.cursor_visible = false;
    text_view.buffer.text = read_stdin();
    text_view.set_monospace(true);
    window.add (text_view);
    window.show_all ();

    Gtk.main ();
    return 0;
}
