import mongoose from "mongoose";

const deviceSchema = new mongoose.Schema({
    userId:{
        type:mongoose.Schema.Types.ObjectId,
        ref:"User",
        required:true,
    },
    name:{
        type:String,
        required:true,
    },
    wattage:{
        type:Number,
        required:true,
    },
    hoursUsed:{
        type:Number,
        required:true,
    }
}, {timestamps:true});

export const Device = mongoose.model('Device', deviceSchema);
