# usage: blender -b --factory-startup --python fbx_to_obj.py -- <in.fbx> <out.obj> <height in units> <mesh,names,to,keep>
# e.g. the cactus: ... -- cactus_body_default_mesh.fbx enh_cactus.obj 72 "Cactus_Body_Default_M:cactus_body_default_mesh_lod.000,..."
# list the mesh names first with the blender python console or an import, lod0 only (the linker takes one lod)
# fbx (frostbite export) -> rigid obj for the acts xmodel linker: lod0, rest pose, z up, facing +x, on the ground
import bpy, sys, math
from mathutils import Matrix, Vector
args = sys.argv[sys.argv.index("--") + 1:]
src, dst, height = args[0], args[1], float(args[2])
keep = args[3].split(",")
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.fbx(filepath=src)
for a in [o for o in bpy.data.objects if o.type == 'ARMATURE']:
    a.data.pose_position = 'REST'
    # blender faces -y, cod faces +x
    a.matrix_world = Matrix.Rotation(math.radians(90), 4, 'Z') @ a.matrix_world
bpy.context.view_layer.update()
bpy.ops.object.select_all(action='DESELECT')
sel = [o for o in bpy.data.objects if o.type == 'MESH' and o.name in keep]
for o in sel:
    o.select_set(True)
dg = bpy.context.evaluated_depsgraph_get()
pts = []
for o in sel:
    me = o.evaluated_get(dg).to_mesh()
    pts += [o.matrix_world @ v.co for v in me.vertices]
mn = Vector([min(p[i] for p in pts) for i in range(3)]); mx = Vector([max(p[i] for p in pts) for i in range(3)])
scale = height / (mx.z - mn.z)
off = Vector(((mn.x + mx.x) / 2, (mn.y + mx.y) / 2, mn.z))
for a in [o for o in bpy.data.objects if o.type == 'ARMATURE']:
    # the obj exporter caps global_scale at 10000: scaled in the scene
    a.matrix_world = Matrix.Scale(scale, 4) @ Matrix.Translation(-off) @ a.matrix_world
bpy.context.view_layer.update()
print("selected", [o.name for o in sel], "raw bounds", tuple(mn), tuple(mx), "scale", scale)
bpy.ops.wm.obj_export(filepath=dst, export_selected_objects=True, apply_modifiers=True, export_triangulated_mesh=True,
                      export_normals=True, export_uv=True, export_materials=False, export_colors=False,
                      forward_axis='Y', up_axis='Z', global_scale=1.0)
print("written", dst)
