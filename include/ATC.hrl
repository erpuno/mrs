-ifndef(MRS_ATC).
-define(MRS_ATC, true).

-record('ATC', {
  id = [],
  atc_code = [],
  atc_desc = [],
  atc_name_en = [],
  atc_name_ua = [],
  reason = [],
  source_list_id = [],
  source_term_id = [],
  status = [],
  version = [],
  createdAt = [],
  updatedAt = []
}).

-endif.
