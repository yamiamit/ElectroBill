import { Bill } from '../models/Bill.js';

export const addBill = async (req, res) => {
  const { id } = req.query;
  const { amount, unitsConsumed, billingPeriod } = req.body;

  try {
    const bill = new Bill({
      userId: id,
      amount,
      unitsConsumed,
      billingPeriod
    });

    await bill.save();
    res.status(201).json(bill);
  } catch (error) {
    res.status(500).json({ message: 'Failed to add bill', error: error.message });
  }
};

export const getBillsByUser = async (req, res) => {
  const { id } = req.params;
  try {
    const bills = await Bill.find({ userId: id });
    res.status(200).json(bills);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch bills', error: error.message });
  }
};

export const updateBill = async (req, res) => {
  const { userid, id } = req.query;
  const { amount, unitsConsumed, billingPeriod } = req.body;

  try {
    const bill = await Bill.findOne({ _id: id, userId: userid });

    if (!bill) {
      return res.status(404).json({ message: 'Bill not found' });
    }

    bill.amount = amount ?? bill.amount;
    bill.unitsConsumed = unitsConsumed ?? bill.unitsConsumed;
    bill.billingPeriod = billingPeriod ?? bill.billingPeriod;

    await bill.save();
    res.status(200).json(bill);
  } catch (error) {
    res.status(500).json({ message: 'Failed to update bill', error: error.message });
  }
};

export const deleteBill = async (req, res) => {
  const { userid, id } = req.query;

  try {
    const bill = await Bill.findOneAndDelete({ _id: id, userId: userid });

    if (!bill) {
      return res.status(404).json({ message: 'Bill not found' });
    }

    res.status(200).json({ message: 'Bill deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Failed to delete bill', error: error.message });
  }
};
