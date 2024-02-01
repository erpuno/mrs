defmodule MRS.Data do
  require MRS

  # Generator
  # :io.format '~s', [:lists.map(fn x -> a = :erlang.binary_to_list(x)
  #  "#{a}: Map.get(sku, \"#{a}\", []),\n" end, Map.keys hd(sku))]

  def fix(:null), do: []
#  def fix([o]) when is_map(o), do: :lists.map(fn x -> Map.get(o,x,[]) end, Map.keys(o))
  def fix(x), do: x

  def readSKU(sku) do
      MRS."SKU"(
        id: Map.get(sku, "id", []),
        container_id: Map.get(sku, "container_id", []),
        atc:            '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "atc_code",[]) ; '#{code}' end, fix(Map.get(sku, "atccode", []))), ',') ++ ']',
        authorizations: '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "id",[])       ; '#{code}' end, fix(Map.get(sku, "authorizations", []))), ',') ++ ']',
        containers:     '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "id",[])       ; '#{code}' end, fix(Map.get(sku, "containers", []))), ',') ++ ']',
        ingredients:    '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "inn_id",[])   ; '#{code}' end, fix(Map.get(sku, "ingredients", []))), ',') ++ ']',
        manufacturers:  '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "id",[])       ; '#{code}' end, fix(Map.get(sku, "manufacturers", []))), ',') ++ ']',
        sku_id: Map.get(sku, "sku_id", []))
  end

  def readPackage(package) do
      MRS."Package"(
        id: Map.get(package, "id", []),
        desc_en: Map.get(package, "description_en", []),
        desc_ua: Map.get(package, "description_ua", []),
        name_en: Map.get(package, "name_en", []),
        name_ua: Map.get(package, "name_ua", []),
        reason: Map.get(package, "reason_of_changes", []),
        source_list_id: Map.get(package, "source_list_id", []),
        source_term_id: Map.get(package, "source_term_id", []),
        status: Map.get(package, "status", []),
        version: Map.get(package, "version", []),
        createdAt: Map.get(package, "created_on", []),
        updatedAt: Map.get(package, "modified_on", []))
  end

  def readINN(inn) do
      MRS."INN"(
        id: Map.get(inn, "id", []),
        inn_type: Map.get(inn, "inn_type"),
        name_en: Map.get(inn, "name_en", []),
        name_ua: Map.get(inn, "name_ua", []),
        reason: Map.get(inn, "reason_of_changes", []),
        source_list_id: Map.get(inn, "source_list_id", []),
        source_term_id: Map.get(inn, "source_term_id", []),
        status: Map.get(inn, "status", []),
        version: Map.get(inn, "version", []),
        createdAt: Map.get(inn, "created_on", []),
        updatedAt: Map.get(inn, "modified_on", []))
  end

  def readATC(atc) do
      MRS."ATC"(
        id: Map.get(atc, "id", []),
        atc_code: Map.get(atc, "atc_code"),
        atc_desc: Map.get(atc, "atc_desc"),
        atc_name_ua: Map.get(atc, "atc_name_en", []),
        atc_name_en: Map.get(atc, "atc_name_ua", []),
        reason: Map.get(atc, "reason_of_changes", []),
        source_list_id: Map.get(atc, "source_list_id", []),
        source_term_id: Map.get(atc, "source_term_id", []),
        status: Map.get(atc, "status", []),
        version: Map.get(atc, "version", []),
        createdAt: Map.get(atc, "created_on", []),
        updatedAt: Map.get(atc, "modified_on", []))
  end

  def readManufacturer(manufacturer) do
      MRS."Manufacturer"(
        id: Map.get(manufacturer, "id", []),
        name: "\"" <> Map.get(manufacturer, "name", "") <> "\"",
        country: '[' ++ :string.join(:lists.map(fn x -> :erlang.integer_to_list(x) end, Map.get(manufacturer, "country", [])), ',') ++ ']',
        country_str: "\"" <> Map.get(manufacturer, "country_str", "") <> "\"",
        address: Map.get(manufacturer, "manufacturing_facilities_address", []),
        reason: Map.get(manufacturer, "reason_of_changes", []),
        source_list_id: Map.get(manufacturer, "source_list_id", []),
        source_term_id: Map.get(manufacturer, "source_term_id", []),
        status: Map.get(manufacturer, "status", []),
        version: Map.get(manufacturer, "version", []),
        createdAt: Map.get(manufacturer, "created_on", []),
        updatedAt: Map.get(manufacturer, "modified_on", []))
  end

  def readRegistry(reg) do
      MRS."Registry"(
        id: Map.get(reg, "id", []),
        name_eng: Map.get(reg, "name_eng", []),
        chemical_name: Map.get(reg, "chemical_name", []),
        number_of_doses: Map.get(reg, "number_of_doses", []),
        expiration_unit: Map.get(reg, "expiration_unit", []),

# TEXT:
#        undesirable_effect_symptom_condition_effect: Map.get(reg, "undesirable_effect_symptom_condition_effect", []),
#        interaction: Map.get(reg, "interaction", []),
#        storage_conditions: Map.get(reg, "storage_conditions", []),
#        medicinal_form: Map.get(reg, "medicinal_form", []),
#        special_indications: Map.get(reg, "special_indications", []),
#        ingredient: Map.get(reg, "ingredient", []),
#        contraindications: Map.get(reg, "contraindications", []),
#        indications: Map.get(reg, "indications", []),
#        additional_ingredient: Map.get(reg, "additional_ingredient", []),
#        mechanism_of_action: Map.get(reg, "mechanism_of_action", []),
#        dosage: Map.get(reg, "dosage", []),
#        expiration_term_text: Map.get(reg, "expiration_term_text", []),

        advertisement_prohibition: Map.get(reg, "advertisement_prohibition", []),
        is_samples_of_writing: Map.get(reg, "is_samples_of_writing", []),
        child_age: Map.get(reg, "child_age", []),
        max_dose_per_day_unit: Map.get(reg, "max_dose_per_day_unit", []),
        public_procurement_status: Map.get(reg, "public_procurement_status", []),
        is_authenticity: Map.get(reg, "is_authenticity", []),
        group: Map.get(reg, "group", []),
        advertisement_prohibition_reason: Map.get(reg, "advertisement_prohibition_reason", []),
        expiration_term: Map.get(reg, "expiration_term", []),
        is_for_certain_disease: Map.get(reg, "is_for_certain_disease", []),
        form_group: Map.get(reg, "form_group", []),
        origin: Map.get(reg, "origin", []),
        who_dosage_unit: Map.get(reg, "who_dosage_unit", []),
        status_description: Map.get(reg, "status_description", []),
        stop_ahead_of_schedule: Map.get(reg, "stop_ahead_of_schedule", []),
        product_type: Map.get(reg, "product_type", []),
        is_deleted: Map.get(reg, "is_deleted", []),
        is_psychotropic: Map.get(reg, "is_psychotropic", []),
        reason_of_changes: Map.get(reg, "reason_of_changes", []),
        attached_document: Map.get(reg, "attached_document", []),
        marketing_status: Map.get(reg, "marketing_status", []),
        atc_codes: '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "atc_code",[]) ; '#{code}' end, fix(Map.get(reg, "atccode", []))), ',') ++ ']',
        version: Map.get(reg, "version", []),
        containers: '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "id",[]) ; '#{code}' end, fix(Map.get(reg, "containers", []))), ',') ++ ']',
        files: '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "id",[]) ; '#{code}' end, fix(Map.get(reg, "files", []))), ',') ++ ']',
        is_biologic: Map.get(reg, "is_biologic", []),
        legal_status_of_supply: Map.get(reg, "legal_status_of_supply", []),
        is_homeopathic: Map.get(reg, "is_homeopathic", []),
        is_exclusive: Map.get(reg, "is_exclusive", []),
        is_poisonous: Map.get(reg, "is_poisonous", []),
        group_of_mp: Map.get(reg, "group_of_mp", []),
        is_original_medicinal_product: Map.get(reg, "is_original_medicinal_product", []),
        manufacturers: '[' ++ :string.join(:lists.map(fn x -> code = Map.get(x, "id",[]) ; '#{code}' end, fix(Map.get(reg, "manufacturers", []))), ',') ++ ']',
        number_of_packages: Map.get(reg, "number_of_packages", []),
        created_on: Map.get(reg, "created_on", []),
        modified_on: Map.get(reg, "modified_on", []),
        is_urgent: Map.get(reg, "is_urgent", []),
        is_original: Map.get(reg, "is_original", []),
        authorization_holder: Map.get(reg, "authorization_holder", []),
        other_countries_registration_status: Map.get(reg, "other_countries_registration_status", []),
        authorization: '[' ++ :string.join(:lists.map(fn x ->
          code = Map.get(x, "authorization_reference_number",[])
          start = Map.get(x, "begin_date",[])
          finish = Map.get(x, "end_date",[])
          '#{code}:#{start}:#{finish}'
        end, fix(Map.get(reg, "manufacturers", []))), ',') ++ ']',
        inn: Map.get(reg, "inn", []),
        is_plant: Map.get(reg, "is_plant", []),
        is_emergency_registration: Map.get(reg, "is_emergency_registration", []),
        is_child_friendly: Map.get(reg, "is_child_friendly", []),
        national_registry: Map.get(reg, "national_registry", []),
        is_form3: Map.get(reg, "is_form3", []),
        need_of_prescription: Map.get(reg, "need_of_prescription", []),
        stop_ahead_of_schedule_date: Map.get(reg, "stop_ahead_of_schedule_date", []),
        max_dose_per_day_quantity: Map.get(reg, "max_dose_per_day_quantity", []),
        is_highly_potent: Map.get(reg, "is_highly_potent", []),
        who_dosage_quantity: Map.get(reg, "who_dosage_quantity", []),
        synonyms: Map.get(reg, "synonyms", []),
        external_id: Map.get(reg, "external_id", []),
        who_dosage_adm_route: Map.get(reg, "who_dosage_adm_route", []),
        is_orphan: Map.get(reg, "is_orphan", []))
  end

  def writeFile(record, name) do
      bin = :string.join(:lists.map(fn x ->
#         :io.format 'debud: ~p~n', [{x,name}]
         '#{x}' end, tl(:erlang.tuple_to_list(record))),';') ++ '\n'
      :file.write_file("priv/#{name}.csv", "#{bin}", [:append, :raw, :binary])
      record
  end

  def convertRegistry(list \\ MRS.Service.registry()), do: (:lists.map(fn x -> readRegistry(x)      end, list) |> :lists.sort) |> Enum.map(fn x -> writeFile(x,"reg") end)
  def convertSKU(list \\ MRS.Service.sku()),           do: (:lists.map(fn x -> readSKU(x)           end, list) |> :lists.sort) |> Enum.map(fn x -> writeFile(x,"sku") end)
  def convertManufacturer(list \\ MRS.Service.manufacturers()),  do: (:lists.map(fn x -> readManufacturer(x)  end, list) |> :lists.sort) |> Enum.map(fn x -> writeFile(x,"man") end)
  def convertINN(list \\ MRS.Service.inn()),           do: (:lists.map(fn x -> readINN(x)           end, list) |> :lists.sort) |> Enum.map(fn x -> writeFile(x,"inn") end)
  def convertATC(list \\ MRS.Service.atc()),           do: (:lists.map(fn x -> readATC(x)           end, list) |> :lists.sort) |> Enum.map(fn x -> writeFile(x,"atc") end)
  def convertPackage(list \\ MRS.Service.packages()),  do: (:lists.map(fn x -> readPackage(x)       end, list) |> :lists.sort) |> Enum.map(fn x -> writeFile(x,"pkg") end)

end
