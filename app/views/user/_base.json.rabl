# Attributes to include for each user
attributes :id, :name

# Include focuses projects tickets procedures
# NOTE: Currently each focus_area has projects and focus areas and projects
# has tickets. This adds a bunch of queries. We could just get each focus_area,
# project, procedure, and ticket for this user and have 5 queries.
# NOTE: Could just pass down focus_areas, that has everything else in it.
child(:focus_areas) { extends "focus_area/_base" }
child(:procedures)  { extends "procedure/_base" }
child(:projects)    { extends "project/_base" }
child(:tickets)     { extends "ticket/_base" }