-ifndef(MRS_PACKAGE).
-define(MRS_PACKAGE, true).

-record('Package', {
  id = [],
  desc_ua = [],
  desc_en = [],
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
