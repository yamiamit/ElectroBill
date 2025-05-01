import { Device } from '../models/Device.js';

export const addDevice = async (req, res) => {
    console.log("Adding device...");
    const { id } = req.query;
    console.log("User ID:", id);
  try {
    const { name, wattage, hoursUsed } = req.body;

    const device = new Device({
      userId: id,
      name,
      wattage,
      hoursUsed
    });

    await device.save();
    res.status(201).json(device);
  } catch (error) {
    res.status(500).json({ message: 'Failed to add device', error: error.message });
  }
};

export const getDevice = async (req, res) => {
    const { id } = req.query;
  try {
    const devices = await Device.find({ userId: id });
    res.status(200).json(devices);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch devices', error: error.message });
  }
};


export const updateDevice = async (req, res) => {
    try {
      const { userid, id } = req.query;
      const device = await Device.findOne({ _id: id, userId:userid });
  
      if (!device) {
        return res.status(404).json({ message: 'Device not found' });
      }
  
      const { name, wattage, hoursUsed } = req.body;
  
      device.name = name ?? device.name;
      device.wattage = wattage ?? device.wattage;
      device.hoursUsed = hoursUsed ?? device.hoursUsed;
  
      await device.save();
      res.status(200).json(device);
    } catch (error) {
      res.status(500).json({ message: 'Failed to update device', error: error.message });
    }
  };

  
export const deleteDevice = async (req, res) => {
    try {
      const { id } = req.query;
      const device = await Device.findOneAndDelete({ _id: id, userId: req.user.id });
  
      if (!device) {
        return res.status(404).json({ message: 'Device not found or already deleted' });
      }
  
      res.status(200).json({ message: 'Device deleted successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Failed to delete device', error: error.message });
    }
  };

