-ifndef(MRS_SKU).
-define(MRS_SKU, true).

-record('SKU', {
  id = [],
  atc = [],
  container_id = [],
  containers = [],
  ingredients = [],
  manufacturers = [],
  authorizations = [],
  sku_id = []
}).

-endif.
