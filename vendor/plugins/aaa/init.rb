#require 'facets'

class ::Date
  MONTHNAMES  	=  	[nil] + %w(Ianuarie Februarie Martie Aprilie Mai Iunie Iulie August Septembrie Octombrie Noiembrie Decembrie)  	   	
  DAYNAMES 	= 	%w(Duminica Luni Marti Miercuri Joi Vineri Sambata) 
  ABBR_MONTHNAMES 	= 	[nil] + %w(Ian Feb Mar Apr Mai Iun Iul Aug Sep Oct Noi Dec) 	
  ABBR_DAYNAMES 	= 	%w(Dum Lun Mar Mie Joi Vin Sam)
end

class ::Date
  module Format

    MONTHS =  {
      'ianuarie'  => 1, 'februarie' => 2, 'martie'    => 3, 'aprilie'    => 4,
      'mai'      => 5, 'iunie'     => 6, 'iulie'     => 7, 'august'   => 8,
      'septembrie'=> 9, 'octombrie'  =>10, 'noiembrie' =>11, 'decembrie' =>12
    }

    DAYS = {
      'duminica'   => 0, 'luni'   => 1, 'marti'  => 2, 'miercuri'=> 3,
      'joi' => 4, 'vineri'   => 5, 'sambata' => 6
    }

    ABBR_MONTHS = {
      'ian'      => 1, 'feb'      => 2, 'mar'      => 3, 'apr'      => 4,
      'mai'      => 5, 'iun'      => 6, 'iul'      => 7, 'aug'      => 8,
      'sep'      => 9, 'oct'      =>10, 'noi'      =>11, 'dec'      =>12
    }

    ABBR_DAYS = {
      'dum'      => 0, 'lun'      => 1, 'mar'      => 2, 'mie'      => 3,
      'joi'      => 4, 'vin'      => 5, 'sam'      => 6
    }
  end
end

class ::String
  def clean_as_title
    downcase.strip.humanize.gsub(/\b([a-z])/) { $1.capitalize }    
  end  
  def clean_as_description
    
  end
end
