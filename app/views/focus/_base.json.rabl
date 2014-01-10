# Attributes to include for each focus
attributes :id, :title, :notes

# Include projects (with tickets attached) and procedures for each focus.
child(:projects)   { extends "project/base" }
child(:procedures) { extends "procedure/base" }
