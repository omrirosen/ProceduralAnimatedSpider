//Maya ASCII 2018 scene
//Name: temp_twist_script.ma
//Last modified: Sat, Jul 06, 2019 12:38:47 PM
//Codeset: 1252
requires maya "2018";
requires "stereoCamera" "10.0";
currentUnit -l centimeter -a degree -t 59.94fps;
fileInfo "application" "maya";
fileInfo "product" "Maya 2018";
fileInfo "version" "2018";
fileInfo "cutIdentifier" "201706261615-f9658c4cfc";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode transform -n "twist_joints_script";
	rename -uid "51150038-4833-B9B6-4B72-6DAA06E41D5E";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".nts" -type "string" (
		"import pymel.core as pm\n\nright_upperarm_twist_joint = create_twist_joint(pm.PyNode('RightUpperArm'), pm.PyNode('RightLowerArm'), 'RightUpperArmTwist')\nconnect_blended_twist_joint(right_upperarm_twist_joint, pm.PyNode('RightUpperArmTwist1'), 1.0)\nconnect_blended_twist_joint(right_upperarm_twist_joint, pm.PyNode('RightUpperArmTwist2'), 0.75)\nconnect_blended_twist_joint(right_upperarm_twist_joint, pm.PyNode('RightUpperArmTwist3'), 0.5)\n\nright_lowerarm_twist_joint = create_twist_joint(pm.PyNode('RightLowerArm'), pm.PyNode('RightHand'), 'RightLowerArmTwist', False)\nconnect_blended_twist_joint(right_lowerarm_twist_joint, pm.PyNode('RightLowerArmTwist1'), 1.0)\nconnect_blended_twist_joint(right_lowerarm_twist_joint, pm.PyNode('RightLowerArmTwist2'), 0.75)\nconnect_blended_twist_joint(right_lowerarm_twist_joint, pm.PyNode('RightLowerArmTwist3'), 0.5)\n\nleft_upperarm_twist_joint = create_twist_joint(pm.PyNode('LeftUpperArm'), pm.PyNode('LeftLowerArm'), 'LeftUpperArmTwist')\nconnect_blended_twist_joint(left_upperarm_twist_joint, pm.PyNode('LeftUpperArmTwist1'), 1.0)\n"
		+ "connect_blended_twist_joint(left_upperarm_twist_joint, pm.PyNode('LeftUpperArmTwist2'), 0.75)\nconnect_blended_twist_joint(left_upperarm_twist_joint, pm.PyNode('LeftUpperArmTwist3'), 0.5)\n\nleft_lowerarm_twist_joint = create_twist_joint(pm.PyNode('LeftLowerArm'), pm.PyNode('LeftHand'), 'LeftLowerArmTwist', False)\nconnect_blended_twist_joint(left_lowerarm_twist_joint, pm.PyNode('LeftLowerArmTwist1'), 1.0)\nconnect_blended_twist_joint(left_lowerarm_twist_joint, pm.PyNode('LeftLowerArmTwist2'), 0.75)\nconnect_blended_twist_joint(left_lowerarm_twist_joint, pm.PyNode('LeftLowerArmTwist3'), 0.5)\n\nright_upperleg_twist_joint = create_twist_joint(pm.PyNode('RightUpperLeg'), pm.PyNode('RightLowerLeg'), 'RightUpperLegTwist')\nconnect_blended_twist_joint(right_upperleg_twist_joint, pm.PyNode('RightUpperLegTwist1'), 1.0)\nconnect_blended_twist_joint(right_upperleg_twist_joint, pm.PyNode('RightUpperLegTwist2'), 0.75)\nconnect_blended_twist_joint(right_upperleg_twist_joint, pm.PyNode('RightUpperLegTwist3'), 0.5)\n\nleft_upperleg_twist_joint = create_twist_joint(pm.PyNode('LeftUpperLeg'), pm.PyNode('LeftLowerLeg'), 'LeftUpperLegTwist')\n"
		+ "connect_blended_twist_joint(left_upperleg_twist_joint, pm.PyNode('LeftUpperLegTwist1'), 1.0)\nconnect_blended_twist_joint(left_upperleg_twist_joint, pm.PyNode('LeftUpperLegTwist2'), 0.75)\nconnect_blended_twist_joint(left_upperleg_twist_joint, pm.PyNode('LeftUpperLegTwist3'), 0.5)\n\n\ndef create_twist_joint(upper_joint, lower_joint, name_root, shoulder_option=True):\n    pm.select(upper_joint)\n    twist_joint = pm.joint(n=name_root)\n    pm.select(upper_joint)\n    twist_joint_null = pm.joint(n='{0}_null'.format(name_root))\n    \n    if shoulder_option:\n        twist_joint.translate.set(lower_joint.translate.get())\n        twist_joint_null.setParent(twist_joint)\n    else:\n        twist_joint_null.translate.set(lower_joint.translate.get())\n        twist_joint_null.setParent(twist_joint)\n    \n    ik_handle, ik_effector = pm.ikHandle( sj=twist_joint, ee=twist_joint_null, n='{0}_ikHandle'.format(name_root))\n    \n    dnt_group = pm.group(em=True, n='{0}_doNotTouch'.format(name_root))\n    dnt_group.setParent(upper_joint)\n    dnt_group.translate.set([0,0,0])\n"
		+ "    dnt_group.rotate.set([0,0,0])\n    #dnt_group.setParent('rea:doNotTouch')\n    \n    #twist_joint.setParent(dnt_group)\n    #pm.parentConstraint(upper_joint, twist_joint, mo=True)\n    twist_joint.setParent(upper_joint)\n    if shoulder_option:\n        ik_handle.setParent(upper_joint.getParent())\n    else:\n        ik_handle.setParent(lower_joint)\n    #ik_effector.setParent(twist_joint)\n    #pm.parentConstraint(upper_joint.getParent(), ik_handle[0], mo=True)\n    \n    return twist_joint\n\ndef connect_blended_twist_joint(driver, driven, weight):\n    name_root = driven.name()\n    twist_interface = pm.group(em=True, n='{0}_twistInterface'.format(name_root))\n    dnt_group = pm.group(n='{0}_doNotTouch'.format(name_root))\n    dnt_group.setParent(driven)\n    dnt_group.translate.set([0,0,0])\n    dnt_group.rotate.set([0,0,0])\n    dnt_group.setParent(driven.getParent())\n    #dnt_group.setParent('rea:doNotTouch')\n    #pm.parentConstraint(driven.getParent(), dnt_group, mo=True)\n    \n    multiply_node = pm.createNode('multiplyDivide', n='{0}_multiplyDivide'.format(name_root))\n"
		+ "    driver.rx >> multiply_node.input1X\n    multiply_node.outputX >> twist_interface.rx\n    multiply_node.input2X.set(weight)\n    pm.orientConstraint(twist_interface, driven, sk=['z','y'], mo=False)\n    \n    return dnt_group\n");
select -ne :time1;
	setAttr -av -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".o" 0;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
select -ne :renderPartition;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 8 ".st";
	setAttr -cb on ".an";
	setAttr -cb on ".pt";
select -ne :renderGlobalsList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
select -ne :defaultShaderList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 10 ".s";
select -ne :postProcessList1;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :defaultTextureList1;
	setAttr -s 24 ".tx";
select -ne :initialShadingGroup;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
select -ne :initialParticleSE;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -av -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".mwc";
	setAttr -cb on ".an";
	setAttr -cb on ".il";
	setAttr -cb on ".vo";
	setAttr -cb on ".eo";
	setAttr -cb on ".fo";
	setAttr -cb on ".epo";
	setAttr -k on ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr -k on ".macc";
	setAttr -k on ".macd";
	setAttr -k on ".macq";
	setAttr -cb on ".ifg";
	setAttr -k on ".clip";
	setAttr -k on ".edm";
	setAttr -k on ".edl";
	setAttr -k on ".ren";
	setAttr -av -k on ".esr";
	setAttr -k on ".ors";
	setAttr -cb on ".sdf";
	setAttr -k on ".outf";
	setAttr -k on ".gama";
	setAttr -cb on ".an";
	setAttr ".fs" 1.9980019980019981;
	setAttr ".ef" 19.980019980019978;
	setAttr -av -k on ".bfs";
	setAttr -k on ".be";
	setAttr -k on ".fec";
	setAttr -k on ".ofc";
	setAttr -cb on ".ofe";
	setAttr -cb on ".efe";
	setAttr -cb on ".umfn";
	setAttr -cb on ".pff";
	setAttr -cb on ".peie";
	setAttr -cb on ".ifp";
	setAttr -k on ".comp";
	setAttr -k on ".cth";
	setAttr -k on ".soll";
	setAttr -k on ".rd";
	setAttr -k on ".lp";
	setAttr -av -k on ".sp";
	setAttr -k on ".shs";
	setAttr -k on ".lpr";
	setAttr -cb on ".gv";
	setAttr -cb on ".sv";
	setAttr -k on ".mm";
	setAttr -k on ".npu";
	setAttr -k on ".itf";
	setAttr -k on ".shp";
	setAttr -cb on ".isp";
	setAttr -k on ".uf";
	setAttr -k on ".oi";
	setAttr -k on ".rut";
	setAttr -av -k on ".mbf";
	setAttr -k on ".afp";
	setAttr -k on ".pfb";
	setAttr -k on ".pram";
	setAttr -k on ".poam";
	setAttr -k on ".prlm";
	setAttr -k on ".polm";
	setAttr -cb on ".prm";
	setAttr -cb on ".pom";
	setAttr -cb on ".pfrm";
	setAttr -cb on ".pfom";
	setAttr -av -k on ".bll";
	setAttr -k on ".bls";
	setAttr -av -k on ".smv";
	setAttr -k on ".ubc";
	setAttr -k on ".mbc";
	setAttr -cb on ".mbt";
	setAttr -k on ".udbx";
	setAttr -k on ".smc";
	setAttr -k on ".kmv";
	setAttr -cb on ".isl";
	setAttr -cb on ".ism";
	setAttr -cb on ".imb";
	setAttr -k on ".rlen";
	setAttr -av -k on ".frts";
	setAttr -k on ".tlwd";
	setAttr -k on ".tlht";
	setAttr -k on ".jfc";
	setAttr -cb on ".rsb";
	setAttr -k on ".ope";
	setAttr -k on ".oppf";
	setAttr -cb on ".hbl";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr -k on ".cch";
	setAttr -cb on ".ihi";
	setAttr -k on ".nds";
	setAttr -cb on ".bnm";
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
	setAttr -k off ".fbfm";
	setAttr -k off -cb on ".ehql";
	setAttr -k off -cb on ".eams";
	setAttr -k off -cb on ".eeaa";
	setAttr -k off -cb on ".engm";
	setAttr -k off -cb on ".mes";
	setAttr -k off -cb on ".emb";
	setAttr -av -k off -cb on ".mbbf";
	setAttr -k off -cb on ".mbs";
	setAttr -k off -cb on ".trm";
	setAttr -k off -cb on ".tshc";
	setAttr -k off ".enpt";
	setAttr -k off -cb on ".clmt";
	setAttr -k off -cb on ".tcov";
	setAttr -k off -cb on ".lith";
	setAttr -k off -cb on ".sobc";
	setAttr -k off -cb on ".cuth";
	setAttr -k off -cb on ".hgcd";
	setAttr -k off -cb on ".hgci";
	setAttr -k off -cb on ".mgcs";
	setAttr -k off -cb on ".twa";
	setAttr -k off -cb on ".twz";
	setAttr -k on ".hwcc";
	setAttr -k on ".hwdp";
	setAttr -k on ".hwql";
	setAttr -k on ".hwfr";
select -ne :ikSystem;
// End of temp_twist_script.ma
