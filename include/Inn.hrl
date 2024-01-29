-ifndef(MRS_INN).
-define(MRS_INN, true).

-record('INN', {
  id = [],
  inn_type = [],
  name_en = [],
  name_ua = [],
  reason = [],
  source_list_id = [],
  source_term_id = [],
  status = [],
  version = [],
  createdAt = [],
  updatedAt = []
}).

-endif.
