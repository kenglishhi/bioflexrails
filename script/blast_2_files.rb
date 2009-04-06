
sequence_db  = Biodatabase.find_by_name("EST_Clade_A")
target_db  = Biodatabase.find_by_name("EST_Clade_C")
exit unless sequence_db && target_db
puts sequence_db.name
puts target_db.name

Term.delete_all
BioentryRelationship.delete_all
Ontology.delete_all
ontology = Ontology.create(:name => 'Onotology 1')
term = Term.create(:name => 'Term 1', :ontology => ontology ) 

sequence_db.blast_against(target_db,term,{:evalue => 1})

