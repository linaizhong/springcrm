#
# project-show.coffee
#
# Copyright (c) 2011-2013, Daniel Ellermann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#


$ = jQuery


# Changes the current project phase.  The method submits the project phase to
# the server.
#
# @param {String} phaseName the name of the current project phase
#
changePhase = (phaseName) ->
  $ = jQuery
  $.get $("#project-phases").data("set-phase-url"),
    phase: phaseName

# Loads the list of items with the given URL into the selector dialog.
#
# @param {String} url the given URL; if undefined the URL of the currently selected data type is used
#
loadList = (url) ->
  $ = jQuery
  url ?= $("#select-project-item-type-selector :selected").val()

  data =
    view: "selector"
  search = $("#selector-search").val()
  data.search = search if search
  $("#select-project-item-list").load url, data

# Called if the project phase is changed.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onChangeProjectPhase = ->
  $ = jQuery
  $this = $(this)

  $("#project-phase").text $this.text()
  $section = $this.parents("section")
  $section.addClass("current")
    .siblings()
      .removeClass "current"
  changePhase $section.data("phase")
  false

# Called if the checkbox to select or unselect all entries in the item table is
# changed.
#
onChangeTopCheckbox = ->
  $this = $(this)
  $this.parents(".content-table")
    .find("tbody td:first-child input:checkbox")
      .attr "checked", $this.is(":checked")

# Called if the type selector is changed.
#
onChangeType = ->
  $ = jQuery

  $dlg = $("#select-project-item-dialog")
  $this = $(this)
  $option = $this.find(":selected")
  $dlg.find("h2")
    .text $option.text()
  if $option.data("controller") is "document"
    showFileSelector $this.val()
    $dlg.find(".search-field")
      .add(".submit-field", $dlg)
      .add("#select-project-item-list")
        .hide()
    $dlg.find(".filler")
      .add("#select-project-document-list")
        .show()
  else
    $("#selector-search").val ""
    loadList $this.val()
    $dlg.find(".search-field")
      .add(".submit-field", $dlg)
      .add("#select-project-item-list")
        .show()
    $dlg.find(".filler")
      .add("#select-project-document-list")
        .hide()

# Called if the button to add an item has been clicked.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onClickAddBtn = ->
  $ = jQuery
  ids = []
  $("#select-project-item-list tbody :checked").each ->
    ids.push $(this).parents("tr").data("item-id")

  submitSelectedItems ids
  $("#select-project-item-dialog").dialog "close"
  false

# Called if any link in the item selector dialog is clicked.  The method loads
# the link into the same dialog.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onClickLink = ->
  loadList $(this).attr("href")
  false

# Called if an item in the item selector dialog is clicked and thus the item is
# selected.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onClickSelectItem = (event) ->
  $ = jQuery

  event.stopImmediatePropagation()
  itemId = $(this).parents("tr").data("item-id")
  submitSelectedItems [itemId]

  $("#select-project-item-dialog").dialog "close"
  false

# Called if a project item is to create.  The function displays a dialog where
# the user can click on buttons to create a project item of a particular type.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onCreateProjectItem = ->
  $ = jQuery

  phaseName = $(this).parents("section").data("phase")
  $("#create-project-item-dialog").dialog(modal: true)
    .find("a")
      .click ->
        window.location.href = "#{$(this).attr('href')}&projectPhase=#{phaseName}"
        false
  false

# Called if a project item should be deleted.  The function displays a
# confirmation dialog and sends a deletion request to the server.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onDeleteProjectItem = ->
  $ = jQuery
  $this = $(this)

  if $.confirm $L("default.delete.confirm.msg")
    $.get $this.attr("href"), null, ->
      $this.closest("li").remove()
  false

# Called if the item selector dialog is to display.
#
onOpenSelectDlg = ->
  $ = jQuery

  $(this).find(".filler")
    .hide()
  $("#select-project-item-type-selector").trigger "change"

# Called if a project item is to select from a list.  The method displays a
# dialog where the user can select an existing record as project item.
#
# @return {Boolean} always `false` to prevent event bubbling
#
onSelectProjectItem = ->
  $ = jQuery

  phaseName = $(this).parents("section").data("phase")
  $("#select-project-item-dialog").dialog(
      minWidth: 900
      minHeight: 520
      modal: true
      open: onOpenSelectDlg
    )
    .data "phase", phaseName
  false

# Called if the project status is changed.
#
onSelectProjectStatus = ->
  $this = $(this)
  status = $this.val()
  $.get $this.data("submit-url"),
    status: status

  $("#project-status-indicator")
    .attr("class", "project-status-#{status}")
    .text $this.find(":selected").text()

# Called after the item selected from the item selector dialog has been
# submitted to the server.
#
onSubmittedSelectedItems = ->
  window.location.reload true

# Shows the selector to select documents.
#
# @param {String} url the URL used to obtain the documents from the server
#
showFileSelector = (url) ->
  $("#select-project-document-list").elfinder(
    commands: [
      "open", "reload", "home", "up", "back", "forward", "getfile",
      "quicklook", "download", "rm", "duplicate", "rename", "mkdir",
      "mkfile", "upload", "copy", "cut", "paste", "edit", "search", "info",
      "view", "help", "sort"
    ] # "extract", "archive", "resize"
    commandsOptions:
      getfile:
        onlyURL: false
    contextmenu:
      files: [
        "getfile", "|", "open", "quicklook", "|", "download", "|", "copy",
        "cut", "paste", "duplicate", "|", "rm", "|", "edit", "rename", "|",
        "info"
      ]
    getFileCallback: submitSelectedDocuments
    lang: "de"
    uiOptions:
      toolbar: [
        ["back", "forward"],
        ["mkdir", "mkfile", "upload"],
        ["open", "download", "getfile"],
        ["info", "quicklook"],
        ["copy", "cut", "paste"],
        ["rm"],
        ["duplicate", "rename", "edit"],
        ["search"],
        ["view", "sort"],
        ["help"]
      ]
    url: url
  ).elfinder "instance"

# Submits the selected document to the server to associate them to the current
# project.
#
# @param {Object} file  the data of the selected document
#
submitSelectedDocuments = (file) ->
  $ = jQuery
  $dialog = $("#select-project-item-dialog")

  $.post $dialog.data("submit-url"),
      projectPhase: $dialog.data("phase")
      controllerName: "document"
      documents: file.hash
    , onSubmittedSelectedItems

# Submits the selected items to the server to associate them to the current
# project.
#
# @param {Array} ids  the IDs of the selected items
#
submitSelectedItems = (ids) ->
  $ = jQuery
  $dialog = $("#select-project-item-dialog")

  $.post $dialog.data("submit-url"),
      projectPhase: $dialog.data "phase"
      controllerName: $("#select-project-item-type-selector :selected").data "controller"
      itemIds: ids.join()
    , onSubmittedSelectedItems

$("#project-phases").on("click", "h4", onChangeProjectPhase)
  .on("click", ".project-phase-actions-create", onCreateProjectItem)
  .on("click", ".project-phase-actions-select", onSelectProjectItem)
  .on("click", ".item-delete-btn", onDeleteProjectItem)
$("#project-status").selectBoxIt(theme: "jqueryui")
  .change(onSelectProjectStatus)
$("#select-project-item-dialog")
  .on("click", ".search-btn", -> loadList())
  .on("click", "#select-project-item-add-btn", onClickAddBtn)
  .on("change", "#select-project-item-type-selector", onChangeType)
$("#select-project-item-list")
  .on("change", ".content-table th input:checkbox", onChangeTopCheckbox)
  .on("click", ".content-table tbody a", onClickSelectItem)
  .on("click", "a", onClickLink)

