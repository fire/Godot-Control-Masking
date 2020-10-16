extends Control
class_name MaskControl

var mask_material:ShaderMaterial = load("res://MaskedMaterial.tres")

func _process(_time: float):
	var local_xform: Transform2D = Transform2D(Vector2(rect_size.x,0.0), Vector2(0.0,rect_size.y),Vector2(0.5,0.5))
	var mask_to_world_xform: Transform2D = (get_viewport_transform() * get_global_transform() * local_xform)
	mask_material.set_shader_param("mask_transform", mask_to_world_xform.affine_inverse())
	update_child_materials(self, mask_material)

func update_child_materials(p_node, p_mat):
	for N in p_node.get_children():
		if N.get_child_count() > 0:
			update_child_materials(N, p_mat)
		if N is Control:
			var control:Control = N
			if control.material == null:
				control.material = p_mat
			elif control.material.next_pass and control.material.next_pass != p_mat:
				recurse_next_pass(control.material)

func recurse_next_pass(p_mat):
	# TODO
	pass
