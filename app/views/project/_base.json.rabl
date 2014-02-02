# Attributes to include for each project
attributes :id, :title, :notes, :focus_area_id

# Include tickets for each project
child(:tickets) { extends "ticket/_base" }
