const adminDao = require("../models/adminDao");

// admin signup
const adminSignup = async (
  personal_id,
  hashedPassword,
  name,
  branch_name,
  level
) => {
  // 등록할 지점 정보를 가져오기 위한 변수 지정
  const branch_id = await adminDao.getBranchId(branch_name);

  // 등록할 지점이름과 일치하는 지점이 없을 시 에러
  if (branch_id.length === 0) {
    const error = new Error("INVALID_BRANCH_NAME");
    error.statusCode = 406;
    throw error;
  }
  // 이미 등록 된 아이디 일 경우 에러
  const personalId = await adminDao.getPersonalId(personal_id);

  if (personalId !== null) {
    const error = new Error("THE_PERSONAL_ID_ALREADY_EXISTS");
    error.statusCode = 406;
    throw error;
  }

  return await adminDao.adminSignup(
    branch_id[0].id,
    personal_id,
    hashedPassword,
    name,
    level
  );
};

module.exports = {
  adminSignup
};
