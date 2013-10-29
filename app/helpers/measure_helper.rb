module MeasureHelper
  
  def self.get_measure_by_nqf(nqf_ids)

    # return *Measure.where({'measure_id' => {'$in' => nqf_ids || []}}).map(&:to_a).flatten
    return Measure.where('measure_id' => {"$in" => nqf_ids}).all
  end


  def conjunction_translator
    {'allTrue'=>'AND','atLeastOneTrue'=>'OR','XPRODUCT'=>'AND','UNION'=>'OR'}
  end

  def pop_titles
    {'IPP'=>'Initial Patient Population', 'DENOM'=>'Denominator', 'NUMER'=>'Numerator', 'DENEXCEP'=>'Denominator Exceptions', 'DENEX'=>'Denominator Exclusions', 'MSRPOPL'=>'Measure Population', 'OBSERV'=>'Measure Observations'}
  end

  def temporal_text(key)
    @temporal_type_decoder ||= {'DURING'=>'During','SBS'=>'Starts Before Start of','SAS'=>'Starts After Start of',
                     'SBE'=>'Starts Before or During','SAE'=>'Starts After End of','EBS'=>'Ends Before Start of',
                     'EAS'=>'Ends During or After','EBE'=>'Ends Before or During','EAE'=>'Ends After End of',
                     'SDU'=>'Starts During','EDU'=>'Ends During','ECW'=>'Ends Concurrent with','SCW'=>'Starts Concurrent with',
                     'CONCURRENT'=>'Concurrent with'}
    @temporal_type_decoder[key]
  end
  def subset_text(key)
    @subset_type_decoder ||= {'COUNT'=>'COUNT', 'FIRST'=>'FIRST', 'SECOND'=>'SECOND', 'THIRD'=>'THIRD', 'FOURTH'=>'FOURTH',
                       'FIFTH'=>'FIFTH', 'RECENT'=>'MOST RECENT', 'LAST'=>'LAST', 'MIN'=>'MIN', 'MAX'=>'MAX',
                       'MEAN'=>'MEAN', 'MEDIAN'=>'MEDIAN', 'TIMEDIFF'=>'Difference between times', 'DATEDIFF'=>'Difference between dates'}

    @subset_type_decoder[key]
  end

  def unit_text(unit, plural)
    @unit_decoder ||= {'a'=>'year','mo'=>'month','wk'=>'week','d'=>'day','h'=>'hour','min'=>'minute','s'=>'second'}
    if (@unit_decoder[unit])
      @unit_decoder[unit]+( plural ? 's' : '')
    else
      unit
    end
  end

end