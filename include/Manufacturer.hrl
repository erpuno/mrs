-ifndef(MRS_MANUFACTURER).
-define(MRS_MANUFACTURER, true).

-record('Manufacturer', {
  id = [],
  country = [],
  country_str = [],
  name = [],
  address = [],
  reason = [],
  source_list_id = [],
  source_term_id = [],
  status = [],
  version = [],
  createdAt = [],
  updatedAt = []
}).

-endif.
