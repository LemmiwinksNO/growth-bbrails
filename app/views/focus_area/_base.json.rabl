# Attributes to include for each focus_area
attributes :id, :title, :notes

# Include projects (with tickets attached) and procedures for each focus_area.
child(:projects)   { extends "project/_base" }
child(:procedures) { extends "procedure/_base" }
