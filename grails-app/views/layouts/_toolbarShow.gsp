<nav id="toolbar-container">
  <ul id="toolbar">
    <li><g:button action="list" params="${listParams}" color="white" icon="list" message="default.button.list.label" /></li>
    <li><g:button action="create" color="green" icon="plus" message="default.button.create.label" /></li>
    <li><g:button action="edit" id="${instance?.id}" color="green" icon="pencil-square-o" message="default.button.edit.label" /></li>
    <li><g:button action="copy" id="${instance?.id}" color="blue" icon="files-o" message="default.button.copy.label" /></li>
    <li><g:button action="delete" id="${instance?.id}" color="red" class="delete-btn" icon="trash-o" message="default.button.delete.label" /></li>
  </ul>
</nav>

