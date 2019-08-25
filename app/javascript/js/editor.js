import 'easymde/dist/easymde.min.css';
import EasyMDE from 'easymde';

let started = false;

export default class Editor {
  static start(selector) {
    if (!started) {
      document.addEventListener('DOMContentLoaded', function() {
        const editables = document.querySelectorAll(selector);

        for (const editable of editables) {
          new EasyMDE({
            autoDownloadFontAwesome: false,
            element: editable,
            indentWithTabs: false
          });
        }
      });

      started = true;
    }
  }
}
