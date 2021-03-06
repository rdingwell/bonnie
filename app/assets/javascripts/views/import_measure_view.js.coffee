class Thorax.Views.ImportMeasure extends Thorax.View
  template: JST['import/import_measure']
  context: ->
    hqmfSetId = @model.get('hqmf_set_id') if @model?
    measureTypeLabel = if @model?
      if @model.get('type') is 'eh' then 'Eligible Hospital (EH)'
      else if @model.get('type') is 'ep' then 'Eligible Professional (EP)'
    calculationTypeLabel = if @model?
      if @model.get('episode_of_care') is false and @model.get('continuous_variable') is false then 'Patient Based'
      else if @model.get('episode_of_care') is true then 'Episode of Care'
      else if @model.get('continuous_variable') is true then 'Continuous Variable'
    currentRoute = Backbone.history.fragment
    titleSize: 3
    dataSize: 9
    token: $("meta[name='csrf-token']").attr('content')
    dialogTitle: if @model? then @model.get('title') else "New Measure"
    isUpdate: @model?
    measureTypeLabel: measureTypeLabel
    calculationTypeLabel: calculationTypeLabel
    hqmfSetId: hqmfSetId
    redirectRoute: currentRoute

  events:
    'ready': 'setup'

  setup: ->
    @importDialog = @$("#importMeasureDialog")
    @importWait = @$("#pleaseWaitDialog")
    @finalizeDialog = @$("#finalizeMeasureDialog")

  display: ->
    @importDialog.modal(
      "backdrop" : "static",
      "keyboard" : true,
      "show" : true).find('.modal-dialog').css('width','650px')

  submit: ->
    @importDialog.modal('hide')
    @importWait.modal(
      "backdrop" : "static",
      "keyboard" : false,
      "show" : true)
    @$('form').submit()

  # FIXME: Is anything additional required for cleaning up this view on close?
  close: -> ''