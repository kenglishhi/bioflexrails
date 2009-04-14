# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090414084237) do

  create_table "biodatabase", :primary_key => "biodatabase_id", :force => true do |t|
    t.string "name",        :limit => 128, :null => false
    t.string "authority",   :limit => 128
    t.text   "description"
  end

  add_index "biodatabase", ["authority"], :name => "db_auth"
  add_index "biodatabase", ["name"], :name => "name", :unique => true

  create_table "bioentry", :primary_key => "bioentry_id", :force => true do |t|
    t.integer "biodatabase_id",                :null => false
    t.integer "taxon_id"
    t.string  "name",           :limit => 40,  :null => false
    t.string  "accession",      :limit => 128, :null => false
    t.string  "identifier",     :limit => 40
    t.string  "division",       :limit => 6
    t.text    "description"
    t.integer "version",        :limit => 2,   :null => false
  end

  add_index "bioentry", ["accession", "biodatabase_id", "version"], :name => "accession", :unique => true
  add_index "bioentry", ["biodatabase_id"], :name => "bioentry_db"
  add_index "bioentry", ["identifier", "biodatabase_id"], :name => "identifier", :unique => true
  add_index "bioentry", ["name"], :name => "bioentry_name"
  add_index "bioentry", ["taxon_id"], :name => "bioentry_tax"

  create_table "bioentry_dbxref", :id => false, :force => true do |t|
    t.integer "bioentry_id",              :null => false
    t.integer "dbxref_id",                :null => false
    t.integer "rank",        :limit => 2
  end

  add_index "bioentry_dbxref", ["dbxref_id"], :name => "dblink_dbx"

  create_table "bioentry_path", :id => false, :force => true do |t|
    t.integer "object_bioentry_id",  :null => false
    t.integer "subject_bioentry_id", :null => false
    t.integer "term_id",             :null => false
    t.integer "distance"
  end

  add_index "bioentry_path", ["object_bioentry_id", "subject_bioentry_id", "term_id", "distance"], :name => "object_bioentry_id", :unique => true
  add_index "bioentry_path", ["subject_bioentry_id"], :name => "bioentrypath_child"
  add_index "bioentry_path", ["term_id"], :name => "bioentrypath_trm"

  create_table "bioentry_qualifier_value", :id => false, :force => true do |t|
    t.integer "bioentry_id",                :null => false
    t.integer "term_id",                    :null => false
    t.text    "value"
    t.integer "rank",        :default => 0, :null => false
  end

  add_index "bioentry_qualifier_value", ["bioentry_id", "term_id", "rank"], :name => "bioentry_id", :unique => true
  add_index "bioentry_qualifier_value", ["term_id"], :name => "bioentryqual_trm"

  create_table "bioentry_reference", :id => false, :force => true do |t|
    t.integer "bioentry_id",                              :null => false
    t.integer "reference_id",                             :null => false
    t.integer "start_pos"
    t.integer "end_pos"
    t.integer "rank",         :limit => 2, :default => 0, :null => false
  end

  add_index "bioentry_reference", ["reference_id"], :name => "bioentryref_ref"

  create_table "bioentry_relationship", :primary_key => "bioentry_relationship_id", :force => true do |t|
    t.integer "object_bioentry_id",  :null => false
    t.integer "subject_bioentry_id", :null => false
    t.integer "term_id",             :null => false
    t.integer "rank"
  end

  add_index "bioentry_relationship", ["object_bioentry_id", "subject_bioentry_id", "term_id"], :name => "object_bioentry_id", :unique => true
  add_index "bioentry_relationship", ["subject_bioentry_id"], :name => "bioentryrel_child"
  add_index "bioentry_relationship", ["term_id"], :name => "bioentryrel_trm"

  create_table "biosequence", :primary_key => "bioentry_id", :force => true do |t|
    t.integer "version",  :limit => 2
    t.integer "length"
    t.string  "alphabet", :limit => 10
    t.text    "seq",      :limit => 2147483647
  end

  create_table "blast_command", :primary_key => "blast_command_id", :force => true do |t|
    t.integer  "query_biodatabase_id"
    t.integer  "db_biodatabase_id"
    t.integer  "term_id"
    t.float    "evalue"
    t.integer  "identity"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment", :primary_key => "comment_id", :force => true do |t|
    t.integer "bioentry_id",                              :null => false
    t.text    "comment_text",                             :null => false
    t.integer "rank",         :limit => 2, :default => 0, :null => false
  end

  add_index "comment", ["bioentry_id", "rank"], :name => "bioentry_id", :unique => true

  create_table "dbxref", :primary_key => "dbxref_id", :force => true do |t|
    t.string  "dbname",    :limit => 40,  :null => false
    t.string  "accession", :limit => 128, :null => false
    t.integer "version",   :limit => 2,   :null => false
  end

  add_index "dbxref", ["accession", "dbname", "version"], :name => "accession", :unique => true
  add_index "dbxref", ["dbname"], :name => "dbxref_db"

  create_table "dbxref_qualifier_value", :id => false, :force => true do |t|
    t.integer "dbxref_id",                             :null => false
    t.integer "term_id",                               :null => false
    t.integer "rank",      :limit => 2, :default => 0, :null => false
    t.text    "value"
  end

  add_index "dbxref_qualifier_value", ["dbxref_id"], :name => "dbxrefqual_dbx"
  add_index "dbxref_qualifier_value", ["term_id"], :name => "dbxrefqual_trm"

  create_table "fasta_file", :primary_key => "fasta_file_id", :force => true do |t|
    t.string   "label"
    t.string   "fasta_file_name"
    t.string   "fasta_content_type"
    t.integer  "fasta_file_size"
    t.integer  "biodatabase_id"
    t.boolean  "is_generated",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location", :primary_key => "location_id", :force => true do |t|
    t.integer "seqfeature_id",                             :null => false
    t.integer "dbxref_id"
    t.integer "term_id"
    t.integer "start_pos"
    t.integer "end_pos"
    t.integer "strand",        :limit => 1, :default => 0, :null => false
    t.integer "rank",          :limit => 2, :default => 0, :null => false
  end

  add_index "location", ["dbxref_id"], :name => "seqfeatureloc_dbx"
  add_index "location", ["seqfeature_id", "rank"], :name => "seqfeature_id", :unique => true
  add_index "location", ["start_pos", "end_pos"], :name => "seqfeatureloc_start"
  add_index "location", ["term_id"], :name => "seqfeatureloc_trm"

  create_table "location_qualifier_value", :id => false, :force => true do |t|
    t.integer "location_id", :null => false
    t.integer "term_id",     :null => false
    t.string  "value",       :null => false
    t.integer "int_value"
  end

  add_index "location_qualifier_value", ["term_id"], :name => "locationqual_trm"

  create_table "ontology", :primary_key => "ontology_id", :force => true do |t|
    t.string "name",       :limit => 32, :null => false
    t.text   "definition"
  end

  add_index "ontology", ["name"], :name => "name", :unique => true

  create_table "reference", :primary_key => "reference_id", :force => true do |t|
    t.integer "dbxref_id"
    t.text    "location",                :null => false
    t.text    "title"
    t.text    "authors"
    t.string  "crc",       :limit => 32
  end

  add_index "reference", ["crc"], :name => "crc", :unique => true
  add_index "reference", ["dbxref_id"], :name => "dbxref_id", :unique => true

  create_table "seqfeature", :primary_key => "seqfeature_id", :force => true do |t|
    t.integer "bioentry_id",                                 :null => false
    t.integer "type_term_id",                                :null => false
    t.integer "source_term_id",                              :null => false
    t.string  "display_name",   :limit => 64
    t.integer "rank",           :limit => 2,  :default => 0, :null => false
  end

  add_index "seqfeature", ["bioentry_id", "type_term_id", "source_term_id", "rank"], :name => "bioentry_id", :unique => true
  add_index "seqfeature", ["source_term_id"], :name => "seqfeature_fsrc"
  add_index "seqfeature", ["type_term_id"], :name => "seqfeature_trm"

  create_table "seqfeature_dbxref", :id => false, :force => true do |t|
    t.integer "seqfeature_id",              :null => false
    t.integer "dbxref_id",                  :null => false
    t.integer "rank",          :limit => 2
  end

  add_index "seqfeature_dbxref", ["dbxref_id"], :name => "feadblink_dbx"

  create_table "seqfeature_path", :id => false, :force => true do |t|
    t.integer "object_seqfeature_id",  :null => false
    t.integer "subject_seqfeature_id", :null => false
    t.integer "term_id",               :null => false
    t.integer "distance"
  end

  add_index "seqfeature_path", ["object_seqfeature_id", "subject_seqfeature_id", "term_id", "distance"], :name => "object_seqfeature_id", :unique => true
  add_index "seqfeature_path", ["subject_seqfeature_id"], :name => "seqfeaturepath_child"
  add_index "seqfeature_path", ["term_id"], :name => "seqfeaturepath_trm"

  create_table "seqfeature_qualifier_value", :id => false, :force => true do |t|
    t.integer "seqfeature_id",                             :null => false
    t.integer "term_id",                                   :null => false
    t.integer "rank",          :limit => 2, :default => 0, :null => false
    t.text    "value",                                     :null => false
  end

  add_index "seqfeature_qualifier_value", ["term_id"], :name => "seqfeaturequal_trm"

  create_table "seqfeature_relationship", :primary_key => "seqfeature_relationship_id", :force => true do |t|
    t.integer "object_seqfeature_id",  :null => false
    t.integer "subject_seqfeature_id", :null => false
    t.integer "term_id",               :null => false
    t.integer "rank"
  end

  add_index "seqfeature_relationship", ["object_seqfeature_id", "subject_seqfeature_id", "term_id"], :name => "object_seqfeature_id", :unique => true
  add_index "seqfeature_relationship", ["subject_seqfeature_id"], :name => "seqfeaturerel_child"
  add_index "seqfeature_relationship", ["term_id"], :name => "seqfeaturerel_trm"

  create_table "taxon", :primary_key => "taxon_id", :force => true do |t|
    t.integer "ncbi_taxon_id"
    t.integer "parent_taxon_id"
    t.string  "node_rank",         :limit => 32
    t.integer "genetic_code",      :limit => 1
    t.integer "mito_genetic_code", :limit => 1
    t.integer "left_value"
    t.integer "right_value"
  end

  add_index "taxon", ["left_value"], :name => "left_value", :unique => true
  add_index "taxon", ["ncbi_taxon_id"], :name => "ncbi_taxon_id", :unique => true
  add_index "taxon", ["parent_taxon_id"], :name => "taxparent"
  add_index "taxon", ["right_value"], :name => "right_value", :unique => true

  create_table "taxon_name", :id => false, :force => true do |t|
    t.integer "taxon_id",                 :null => false
    t.string  "name",                     :null => false
    t.string  "name_class", :limit => 32, :null => false
  end

  add_index "taxon_name", ["name"], :name => "taxnamename"
  add_index "taxon_name", ["taxon_id", "name", "name_class"], :name => "taxon_id", :unique => true
  add_index "taxon_name", ["taxon_id"], :name => "taxnametaxonid"

  create_table "term", :primary_key => "term_id", :force => true do |t|
    t.string  "name",                      :null => false
    t.text    "definition"
    t.string  "identifier",  :limit => 40
    t.string  "is_obsolete", :limit => 1
    t.integer "ontology_id",               :null => false
  end

  add_index "term", ["identifier"], :name => "identifier", :unique => true
  add_index "term", ["name", "ontology_id", "is_obsolete"], :name => "name", :unique => true
  add_index "term", ["ontology_id"], :name => "term_ont"

  create_table "term_dbxref", :id => false, :force => true do |t|
    t.integer "term_id",                :null => false
    t.integer "dbxref_id",              :null => false
    t.integer "rank",      :limit => 2
  end

  add_index "term_dbxref", ["dbxref_id"], :name => "trmdbxref_dbxrefid"

  create_table "term_path", :primary_key => "term_path_id", :force => true do |t|
    t.integer "subject_term_id",   :null => false
    t.integer "predicate_term_id", :null => false
    t.integer "object_term_id",    :null => false
    t.integer "ontology_id",       :null => false
    t.integer "distance"
  end

  add_index "term_path", ["object_term_id"], :name => "trmpath_objectid"
  add_index "term_path", ["ontology_id"], :name => "trmpath_ontid"
  add_index "term_path", ["predicate_term_id"], :name => "trmpath_predicateid"
  add_index "term_path", ["subject_term_id", "predicate_term_id", "object_term_id", "ontology_id", "distance"], :name => "subject_term_id", :unique => true

  create_table "term_relationship", :primary_key => "term_relationship_id", :force => true do |t|
    t.integer "subject_term_id",   :null => false
    t.integer "predicate_term_id", :null => false
    t.integer "object_term_id",    :null => false
    t.integer "ontology_id",       :null => false
  end

  add_index "term_relationship", ["object_term_id"], :name => "trmrel_objectid"
  add_index "term_relationship", ["ontology_id"], :name => "trmrel_ontid"
  add_index "term_relationship", ["predicate_term_id"], :name => "trmrel_predicateid"
  add_index "term_relationship", ["subject_term_id", "predicate_term_id", "object_term_id", "ontology_id"], :name => "subject_term_id", :unique => true

  create_table "term_relationship_term", :primary_key => "term_relationship_id", :force => true do |t|
    t.integer "term_id", :null => false
  end

  add_index "term_relationship_term", ["term_id"], :name => "term_id", :unique => true

  create_table "term_synonym", :id => false, :force => true do |t|
    t.string  "synonym", :null => false
    t.integer "term_id", :null => false
  end

end
