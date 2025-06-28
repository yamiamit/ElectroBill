import mongoose from 'mongoose';

const billSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    amount: {
        type: Number,
        required: true,
    },
    unitsConsumed: {
        type: Number,
        required: true,
    },
    billingPeriod:{
        from:{type:Date,required:true},
        to:{type:Date,required:true}
    }
},{timestamps:true});

export const Bill = mongoose.model('Bill', billSchema);