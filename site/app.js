/* Checklist — Release B.
   Adds a derived completed/total count. The storage shape is unchanged from release A:
   no count is stored, no field is added and no migration runs.
   Plain browser JavaScript. No dependencies, no network calls. */
(function () {
  'use strict';

  var STORAGE_KEY = 'checklist.state.v1';
  var STATE_KEYS = ['items'];
  var ITEM_KEYS = ['id', 'label', 'completed'];
  var SEEDS = [
    { id: 'seed-1', label: 'Plan the week', completed: false },
    { id: 'seed-2', label: 'Water the plants', completed: true },
    { id: 'seed-3', label: 'Read a chapter', completed: false }
  ];

  var state = {
    mode: 'ready',
    items: [],
    raw: null,
    errorText: '',
    notice: ''
  };
  var idCounter = 0;

  function byId(id) {
    return document.getElementById(id);
  }

  function cloneItems(items) {
    return items.map(function (item) {
      return { id: item.id, label: item.label, completed: item.completed };
    });
  }

  function seedItems() {
    return cloneItems(SEEDS);
  }

  function completedCount() {
    var completed = 0;
    for (var i = 0; i < state.items.length; i += 1) {
      if (state.items[i].completed) {
        completed += 1;
      }
    }
    return completed;
  }

  function countText() {
    return completedCount() + ' of ' + state.items.length + ' completed';
  }

  function isPlainObject(value) {
    return value !== null && typeof value === 'object' && !Array.isArray(value);
  }

  function hasExactKeys(value, keys) {
    var actual = Object.keys(value).sort();
    var expected = keys.slice().sort();
    if (actual.length !== expected.length) {
      return false;
    }
    for (var i = 0; i < actual.length; i += 1) {
      if (actual[i] !== expected[i]) {
        return false;
      }
    }
    return true;
  }

  function isSupportedState(value) {
    if (!isPlainObject(value) || !hasExactKeys(value, STATE_KEYS)) {
      return false;
    }
    if (!Array.isArray(value.items)) {
      return false;
    }
    var seenIds = Object.create(null);
    for (var i = 0; i < value.items.length; i += 1) {
      var item = value.items[i];
      if (!isPlainObject(item) || !hasExactKeys(item, ITEM_KEYS)) {
        return false;
      }
      if (typeof item.id !== 'string' || item.id.length === 0) {
        return false;
      }
      if (typeof item.label !== 'string' || item.label.length === 0) {
        return false;
      }
      if (item.label !== item.label.trim()) {
        return false;
      }
      if (typeof item.completed !== 'boolean') {
        return false;
      }
      if (seenIds[item.id]) {
        return false;
      }
      seenIds[item.id] = true;
    }
    return true;
  }

  function setStorageError(kind, raw) {
    state.mode = 'error';
    state.items = [];
    state.raw = raw;
    state.notice = '';
    if (kind === 'malformed') {
      state.errorText = 'Saved data could not be read because it is not valid JSON. ' +
        'The original bytes are unchanged and are shown below.';
    } else if (kind === 'unsupported') {
      state.errorText = 'Saved data could not be read because it does not use the supported checklist state format. ' +
        'The original bytes are unchanged and are shown below.';
    } else {
      state.errorText = 'Browser storage is unavailable, so saved data could not be read. ' +
        'Nothing has been overwritten.';
    }
  }

  function readStorage() {
    var raw;
    try {
      raw = window.localStorage.getItem(STORAGE_KEY);
    } catch (error) {
      setStorageError('unavailable', null);
      return;
    }
    if (raw === null) {
      state.mode = 'ready';
      state.items = seedItems();
      state.raw = null;
      state.errorText = '';
      return;
    }
    var parsed;
    try {
      parsed = JSON.parse(raw);
    } catch (error) {
      setStorageError('malformed', raw);
      return;
    }
    if (!isSupportedState(parsed)) {
      setStorageError('unsupported', raw);
      return;
    }
    state.mode = 'ready';
    state.items = cloneItems(parsed.items);
    state.raw = raw;
    state.errorText = '';
  }

  function serialize() {
    return JSON.stringify({
      items: state.items.map(function (item) {
        return { id: item.id, label: item.label, completed: item.completed };
      })
    });
  }

  function persist() {
    if (state.mode !== 'ready') {
      return false;
    }
    try {
      window.localStorage.setItem(STORAGE_KEY, serialize());
      return true;
    } catch (error) {
      state.errorText = 'The change could not be saved in this browser. Nothing else was changed.';
      return false;
    }
  }

  function indexOfId(id) {
    for (var i = 0; i < state.items.length; i += 1) {
      if (state.items[i].id === id) {
        return i;
      }
    }
    return -1;
  }

  function newId() {
    var id;
    if (window.crypto && typeof window.crypto.randomUUID === 'function') {
      id = window.crypto.randomUUID();
    } else {
      idCounter += 1;
      id = 'item-' + Date.now().toString(36) + '-' + idCounter.toString(36);
    }
    while (indexOfId(id) !== -1) {
      idCounter += 1;
      id = 'item-' + Date.now().toString(36) + '-' + idCounter.toString(36);
    }
    return id;
  }

  function readyOrExplain() {
    return state.mode === 'ready';
  }

  function clearAlert() {
    var target = byId('error');
    if (target) {
      target.textContent = '';
      target.hidden = true;
    }
  }

  function create(labelValue) {
    if (!readyOrExplain()) {
      return false;
    }
    var label = String(labelValue === null || labelValue === undefined ? '' : labelValue).trim();
    if (label.length === 0) {
      alertMessage('Enter a label before adding an item.', true);
      return false;
    }
    for (var i = 0; i < state.items.length; i += 1) {
      if (state.items[i].label === label) {
        alertMessage('An item with that label already exists. Labels are case-sensitive.', true);
        return false;
      }
    }
    state.items.push({ id: newId(), label: label, completed: false });
    if (!persist()) {
      state.items.pop();
      alertMessage(state.errorText, true);
      render();
      return false;
    }
    state.notice = '';
    clearAlert();
    render();
    return true;
  }

  function toggle(id) {
    if (!readyOrExplain()) {
      return false;
    }
    var index = indexOfId(id);
    if (index === -1) {
      alertMessage('That item is no longer present. Nothing was changed.', true);
      return false;
    }
    state.items[index].completed = !state.items[index].completed;
    if (!persist()) {
      state.items[index].completed = !state.items[index].completed;
      alertMessage(state.errorText, true);
      render();
      return false;
    }
    state.notice = '';
    clearAlert();
    render();
    return true;
  }

  function remove(id) {
    if (!readyOrExplain()) {
      return false;
    }
    var index = indexOfId(id);
    if (index === -1) {
      alertMessage('That item is no longer present. Nothing was changed.', true);
      return false;
    }
    var removed = state.items.splice(index, 1)[0];
    if (!persist()) {
      state.items.splice(index, 0, removed);
      alertMessage(state.errorText, true);
      render();
      return false;
    }
    state.notice = '';
    clearAlert();
    render();
    return true;
  }

  function reset() {
    try {
      window.localStorage.removeItem(STORAGE_KEY);
    } catch (error) {
      alertMessage('Saved data could not be cleared in this browser.', true);
      return false;
    }
    state.mode = 'ready';
    state.items = seedItems();
    state.raw = null;
    state.errorText = '';
    state.notice = 'Saved data was cleared. The initial three items are shown.';
    clearAlert();
    render();
    return true;
  }

  function alertMessage(text, isError) {
    var target = byId(isError ? 'error' : 'notice');
    if (!target) {
      return;
    }
    target.textContent = text || '';
    target.hidden = !text;
  }

  function render() {
    var list = byId('items');
    var form = byId('new-item-form');
    var storageError = byId('storage-error');
    var errorBox = byId('error');
    var noticeBox = byId('notice');
    var rawBox = byId('raw-data');
    var storageText = byId('storage-error-text');
    var input = byId('new-label');
    var countBox = byId('count');

    if (!list) {
      return;
    }
    while (list.firstChild) {
      list.removeChild(list.firstChild);
    }

    var isError = state.mode !== 'ready';
    form.hidden = isError;
    storageError.hidden = !isError;
    if (isError) {
      if (countBox) {
        countBox.textContent = '';
        countBox.hidden = true;
      }
      storageText.textContent = state.errorText;
      rawBox.textContent = state.raw === null ? '(not available)' : state.raw;
      errorBox.hidden = true;
      noticeBox.hidden = true;
    } else {
      errorBox.hidden = !errorBox.textContent;
      noticeBox.textContent = state.notice;
      noticeBox.hidden = !state.notice;
      if (countBox) {
        countBox.textContent = countText();
        countBox.hidden = false;
      }
      if (input) {
        input.disabled = false;
      }
    }

    if (isError) {
      return;
    }

    state.items.forEach(function (item) {
      var row = document.createElement('li');
      row.className = 'item' + (item.completed ? ' is-complete' : '');

      var label = document.createElement('label');
      label.className = 'item-label';

      var checkbox = document.createElement('input');
      checkbox.type = 'checkbox';
      checkbox.checked = item.completed;
      checkbox.setAttribute('aria-label', 'Mark ' + item.label + ' ' + (item.completed ? 'incomplete' : 'complete'));
      checkbox.addEventListener('change', function () {
        toggle(item.id);
      });

      var text = document.createElement('span');
      text.className = 'label-text';
      text.textContent = item.label;

      var status = document.createElement('span');
      status.className = 'state';
      status.textContent = item.completed ? 'Complete' : 'Open';

      label.appendChild(checkbox);
      label.appendChild(text);

      var deleteButton = document.createElement('button');
      deleteButton.type = 'button';
      deleteButton.className = 'delete';
      deleteButton.textContent = 'Delete';
      deleteButton.setAttribute('aria-label', 'Delete ' + item.label);
      deleteButton.addEventListener('click', function () {
        remove(item.id);
      });

      row.appendChild(label);
      row.appendChild(status);
      row.appendChild(deleteButton);
      list.appendChild(row);
    });
  }

  function init() {
    readStorage();
    render();

    var form = byId('new-item-form');
    if (form) {
      form.addEventListener('submit', function (event) {
        event.preventDefault();
        var input = byId('new-label');
        if (!input) {
          return;
        }
        var created = create(input.value);
        if (created) {
          input.value = '';
          input.focus();
        }
      });
    }

    var resetButton = byId('reset-storage');
    if (resetButton) {
      resetButton.addEventListener('click', function () {
        reset();
      });
    }

    if (state.mode === 'ready') {
      var input = byId('new-label');
      if (input) {
        input.focus();
      }
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.checklist = Object.freeze({
    key: STORAGE_KEY,
    getState: function () {
      return {
        mode: state.mode,
        items: cloneItems(state.items)
      };
    },
    create: create,
    toggle: toggle,
    remove: remove,
    reset: reset
  });
})();
