# Grab a handle to the currently active model (aka the one the user is
# looking at in SketchUp.)
model = Sketchup.active_model

# Grab other handles to commonly used collections inside the model.
entities = model.entities
layers = model.layers
materials = model.materials
component_definitions = model.definitions
selection = model.selection


#get the corner of the bounding box
p1 = selection[0].bounds.min
p3 = selection[0].bounds.max

#get the height 
height = p3.z - p1.z 
NB_STEP = 10 
dz = height / NB_STEP

#form the base of the bounding box 
p2 = p1.clone 
p4 = p1.clone 

p2.x = p3.x 
p3.z = p1.z 
p4.y = p3.y 


megaGroup = entities.add_group

group = entities.add_group

group.entities.add_face( p1, p2, p3, p4 )

megaGroup.entities.add_group( group )

for z in 1..10	
	transformation =  Geom::Transformation.translation(group.transformation.origin + [0,0,dz*z] ) 
	groupClone = group.copy
	groupClone.transform! transformation 
	megaGroup.entities.add_group( groupClone )
end
