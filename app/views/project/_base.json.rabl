# Attributes to include for each project
attributes :id, :title, :notes, :focus_id

# Include tickets for each project
child(:tickets) { extends "ticket/_base" }
