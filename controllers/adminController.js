const adminService = require("../services/adminService");
const bcrypt = require("bcrypt");

// admin signup
const adminSignup = async (req, res) => {
  try {
    const {
      personal_id,
      password,
      name,
      branch_name,
      level
    } = req.body;

    //비밀번호 해싱
    const hashedPassword = await bcrypt.hash(password, 10);
    
    if (!personal_id || !password || !name || !branch_name || !level) {
      const error = new Error("KEY_ERROR");
      error.statusCode = 400;
      throw error;
    }
    
    await adminService.adminSignup(
      personal_id,
      hashedPassword,
      name,
      branch_name,
      level
    );
    
    res.status(200).json({ message: "SUCCESS" });
  } catch (err) {
    console.log(err);
    return res.status(err.statusCode || 500).json({ message: err.message });
  }
};

module.exports = {
  adminSignup
};
