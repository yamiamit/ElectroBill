import express from 'express';
import { addDevice,getDevice,updateDevice,deleteDevice } from '../controller/deviceController.js';

const router = express.Router();

router.post('/add', addDevice);
router.get('/get', getDevice);
router.put('/update', updateDevice);
router.delete('/delete', deleteDevice);

export default router;