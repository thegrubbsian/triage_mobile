var Templates = {};
Templates["_header"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('');  if (typeof showBackButton === "undefined") { showBackButton = false; } ; __p.push('\n<header class="bar-title">\n  ');  if (showBackButton) { ; __p.push('\n  <a class="button" id="back-button">\n    <span class="icon-arrow-left"></span>\n  </a>\n  ');  } ; __p.push('\n  <h1 class="title">Triage</h1>\n  <a id="settings-button" class="button">\n    <span class="icon-cog"></span>\n  </a>\n</header>\n');}return __p.join('');};
Templates["_new_task"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<nav id="new-task" class="bar-tab">\n  <form>\n    <input id="new-task-field" type="text" placeholder="New Task" />\n  </form>\n</nav>\n');}return __p.join('');};
Templates["_tabs"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<nav id="tabs" class="bar-standard">\n  <ul id="tabs" class="segmented-controller">\n    <li data-state="now" class="',  selected == "now" ? "active" : "" ,'">\n      <a>\n        <span class="icon-new"></span>\n        <span class="label">Now</span>\n      </a>\n    </li>\n    <li data-state="later" class="',  selected == "later" ? "active" : "" ,'">\n      <a>\n        <span class="icon-clock"></span>\n        <span class="label">Later</span>\n      </a>\n    </li>\n    <li data-state="done" class="',  selected == "done" ? "active" : "" ,'">\n      <a>\n        <span class="icon-checkmark"></span>\n        <span class="label">Done</span>\n      </a>\n    </li>\n  </ul>\n</nav>\n');}return __p.join('');};
Templates["settings_modal"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<header class="bar-title">\n  <a class="button" id="settings-close-button">Close</a>\n  <h1 class="title">Settings</h1>\n</header>\n\n<div class="content content-padded">\n  <a id="sign-out-button" class="button button-block">Sign Out</a>\n</div>\n');}return __p.join('');};
Templates["sign_in"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<div class="content">\n  <div class="content-inner">\n    <form id="sign-in-form">\n      <div id="logo">\n        <span class="icon icon-checkmark-circle"></span>\n        <span class="name">Triage</span>\n      </div>\n      <h3>Sign In</h3>\n      <div class="input-group">\n        <input name="email" type="email" placeholder="Email">\n        <input name="password" type="password" placeholder="Password">\n      </div>\n      <div id="sign-in-error-message" class="error-message">Sign in failed, please try again.</div>\n      <a id="sign-in-button" class="button-main button-block">Sign In</a>\n      <a id="sign-up-link" class="button button-block">Sign Up</a>\n    </form>\n  </div>\n</div>\n');}return __p.join('');};
Templates["task_detail"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('',  Templates._header({ showBackButton: true }) ,'\n<nav class="bar-standard">\n  <h3>Edit Task</h3>\n</nav>\n\n<div class="content">\n  <div class="content-inner">\n    <form>\n      <div class="input-group">\n        <div class="input-row">\n          <label>Title</label>\n          <input type="text" name="name" value="',  task.get("name") ,'" />\n        </div>\n        <div class="input-row">\n          <label>Due Date</label>\n          <input type="date" name="due_at" placeholder="Due Date" />\n        </div>\n      </div>\n      <textarea name="description" placeholder="Notes">',  task.get("description") ,'</textarea>\n      <ul id="state-selector" class="segmented-controller">\n        <li class="',  task.get("state") == "now" ? "active" : "" ,'">\n          <a data-state="now">\n            Now\n            <input type="radio" name="state" value="now" ',  task.get("state") == "now" ? "checked" : "" ,' />\n          </a>\n        </li>\n        <li class="',  task.get("state") == "later" ? "active" : "" ,'">\n          <a data-state="later">\n            Later\n            <input type="radio" name="state" value="later" ',  task.get("state") == "later" ? "checked" : "" ,' />\n          </a>\n        </li>\n        <li class="',  task.get("state") == "done" ? "active" : "" ,'">\n          <a data-state="done">\n            Done\n            <input type="radio" name="state" value="done" ',  task.get("state") == "done" ? "checked" : "" ,' />\n          </a>\n        </li>\n      </ul>\n      <a id="save-button" class="button-main button-block">Save</a>\n      <div class="action-group">\n        <a id="archive-button" class="button-positive button">Archive</a>\n        <a id="delete-button" class="button-negative button">Delete</a>\n      </div>\n    </form>\n  </div>\n</div>\n');}return __p.join('');};
Templates["task_item"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('<li data-id="',  task.id ,'">\n  <span class="order icon-list"></span>\n  <span class="name">',  task.get("name") ,'</span>\n  <span class="arrow icon-arrow-right"></span>\n</li>\n');}return __p.join('');};
Templates["task_list"] = function(obj){var __p=[],print=function(){__p.push.apply(__p,arguments);};with(obj||{}){__p.push('',  Templates._header() ,'\n',  Templates._tabs({ selected: state }) ,'\n\n<div class="content">\n  <ul class="list"></ul>\n</div>\n\n',  Templates._new_task() ,'\n');}return __p.join('');};
