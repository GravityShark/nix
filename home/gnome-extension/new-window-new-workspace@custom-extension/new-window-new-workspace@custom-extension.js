const { Meta } = imports.gi;

class Extension {
    constructor() {
        this._windowCreatedId = 0;
    }

    enable() {
        this._windowCreatedId = global.display.connect(
            'window-created', (dpy, window) => {
                if (window.window_type != Meta.WindowType.NORMAL)
                    return;
                let { workspaceManager } = global;
                let ws = workspaceManager.get_workspace_by_index(
                    workspaceManager.get_n_workspaces() - 1);
                window.change_workspace(ws);
                ws.activate_with_focus(window, global.get_current_time());
            });
    }

    disable() {
        global.display.disconnect(this._windowCreatedId);
        this._windowCreatedId = 0;
    }
}

function init() {
    return new Extension();
}
