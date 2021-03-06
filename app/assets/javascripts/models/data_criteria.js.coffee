class Thorax.Models.MeasureDataCriteria extends Thorax.Model
  toPatientDataCriteria: ->
    # FIXME: Temporary approach
    attr = _(@pick('negation', 'definition', 'status', 'title', 'description', 'type')).extend
             id: @get('source_data_criteria')
             oid: @get('code_list_id')
             start_date: new Date().getTime()
             end_date: new Date().getTime()
             value: new Thorax.Collection()
             field_values: new Thorax.Collection()
    new Thorax.Models.PatientDataCriteria attr

class Thorax.Collections.MeasureDataCriteria extends Thorax.Collection
  model: Thorax.Models.MeasureDataCriteria

# Used for patient encounters. idAttribute is null, as the model itself
# isn't responsible for persisting itself, and the collection must support
# multiple criteria with the same ID.
class Thorax.Models.PatientDataCriteria extends Thorax.Model
  idAttribute: null
  parse: (attrs) ->
    attrs.value = new Thorax.Collection(attrs.value)
    # Transform fieldValues object to collection, one element per key/value, with key as additional attribute
    fieldValues = new Thorax.Collection()
    for key, value of attrs.field_values
      fieldValues.add _(value).extend(id: key)
    attrs.field_values = fieldValues
    attrs
  toJSON: ->
    # Transform fieldValues back to an object from a collection
    fieldValues = {}
    @get('field_values').each (fv) -> fieldValues[fv.id] = _(fv.toJSON()).omit('id')
    _(super).extend(field_values: fieldValues)
  faIcon: ->
    # FIXME: Do this semantically in stylesheet
    icons =
      characteristic:            'fa-user'
      communications:            'fa-files-o'
      conditions:                'fa-stethoscope'
      devices:                   'fa-medkit'
      diagnostic_studies:        'fa-stethoscope'
      encounters:                'fa-user-md'
      functional_statuses:       'fa-stethoscope'
      interventions:             'fa-comments'
      laboratory_tests:          'fa-flask'
      medications:               'fa-medkit'
      physical_exams:            'fa-user-md'
      procedures:                'fa-scissors'
      risk_category_assessments: 'fa-user'
    icons[@get('type')] || 'fa-question'


class Thorax.Collections.PatientDataCriteria extends Thorax.Collection
  model: Thorax.Models.PatientDataCriteria
