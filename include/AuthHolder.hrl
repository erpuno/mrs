-ifndef(MRS_AUTHHOLDER).
-define(MRS_AUTHHOLDER, true).

-record('AuthHolder', {
  id = [],
  code = [],
  name = [],
  country = [],
  country_str = [],
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
