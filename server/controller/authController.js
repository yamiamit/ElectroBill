import User from "../models/User.js";
import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";



const generateToken = (user) => {
    return jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
        expiresIn: '30d',
    });
};

export const register = async (req, res) => {
    try{
        const {name,email,password,consumerId,address} = req.body;
        const existingUser = await User.findOne({email});

        if(existingUser){
            return res.status(400).json({message:"User already exists"});
        }
        const user = await User.create({
            name,
            email,
            password,
            consumerId,
            address
        });
        await user.save();

        res.status(201).json({
            user:{
                id:user._id,
                name:user.name,
                email:user.email,
                consumerId:user.consumerId,
                address:user.address,
            },
            token:generateToken(user),
        });
    }catch(error){
        console.error("Error during registration:", error);
        res.status(500).json({ message: "Server error" });
    }
};

export const login = async (req, res) => {
    try{
        const {email,password} = req.body;

        const user = await User.findOne({email});
        if(!user){
            return res.status(401).json({message:"Invalid email or password"});
        }
        const isMatch = await bcrypt.compare(password,user.password);
        if(!isMatch){
            return res.status(401).json({message:"Invalid email or password"});
        }
        res.status(200).json({
            user:{
                id:user._id,
                name:user.name,
                email:user.email,
                consumerId:user.consumerId,
                address:user.address,
            },
            token:generateToken(user),
        });

    }catch(error){
        console.error("Error during login:", error);
        res.status(500).json({ message: "Server error" });
    }
};


