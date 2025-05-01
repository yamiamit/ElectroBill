import express from 'express';
import { addBill,getBillsByUser,updateBill,deleteBill } from '../controller/billController.js';

const router = express.Router();

router.post('/add', addBill);
router.get('/user', getBillsByUser);
router.put('/update', updateBill);
router.delete('/delete', deleteBill);

export default router;
