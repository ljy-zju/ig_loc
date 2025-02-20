# iG-LOC

**iG-LOC** is a map-based localization method built upon [IG-LIO](https://github.com/zijiechenrobotics/ig_lio).

This work introduces a minimal modification to IG-LIO, enabling localization based on a prior map.

## 🔧 Dependencies & Installation

For dependencies and installation instructions, please refer to the [IG-LIO repository](https://github.com/zijiechenrobotics/ig_lio).

---

## ⚙️ Key Parameters

- **`save_path`**: Path to save the first LiDAR scan, used for initial pose estimation via registration with the prior map (e.g., using CloudCompare).
- **`prior_map_path`**: Path to the prior map (e.g., a `.pcd` file).
- **`init_ok`**: Flag indicating whether the initial pose is accurate. If set to `false`, the system will store the first LiDAR frame after playing the bag file for manual alignment.
- **`t_init`**: Initial pose translation component.
- **`R_init`**: Initial pose rotation component.
- **`en_map_update`**: Whether to enable map updates to incorporate uncovered areas.

📌 **Definition of Initial Pose (`t_init`, `R_init`)**  
The initial pose represents the transformation **from the map coordinate system to the `init_pcd` coordinate system**, which is obtained by aligning the first LiDAR scan with the prior map.

📌 **Recommendation: Downsampling the Prior Map**  
To improve localization accuracy, we recommend **downsampling the original prior map to a voxel size of `0.05m`** before use. You can achieve this using `pcl-tools` or `CloudCompare`
```bash
sudo apt-get install pcl-tools
pcl_voxel_grid -leaf 0.05,0.05,0.05 input.pcd output.pcd
```


---

## 🚀 Usage Guide

1. Modify the parameters in the launch file.
2. Set `init_ok` to `false`.
3. Run the launch file and play the bag file.
4. Manually align the first LiDAR scan with the prior map using CloudCompare or other tools.
5. Set `init_ok` to `true` and provide `t_init` and `R_init` (i.e., the transformation from the map frame to the `init_pcd` frame).
6. Relaunch the system.

This approach allows for robust and accurate localization using an existing prior map while providing flexibility in handling initial pose uncertainties.

---

## 🎯 Demo

We provide a demo using the [FusionPortable dataset](https://fusionportable.github.io/dataset/fusionportable/).

### 🔹 Dataset
The following two sequences have pre-calibrated initial poses, which are available in the corresponding config files:
- **`20220216_escalator_day`** → `fp_esca.yaml`
- **`20220216_canteen_day`** → `fp_canteen.yaml`

### 🔹 Running the Demo
You can directly run localization using the provided launch files:

#### Localizing on the `20220216_escalator_day` sequence
```bash
roslaunch ig_loc loc_fp_esca.launch
rosbag play 20220216_escalator_day.bag
````
#### Localizing on the `20220216_escalator_day` sequence
```bash
roslaunch ig_loc loc_fp_esca.launch
rosbag play 20220216_escalator_day.bag
````
These sequences already contain initial pose configurations in their respective `.yaml` files, so no manual alignment is required.

---

## 📜 License

This project follows the same licensing terms as [IG-LIO](https://github.com/zijiechenrobotics/ig_lio). Please check the original repository for details.

## 🤝 Acknowledgments

Special thanks to the contributors of IG-LIO for their foundational work.  