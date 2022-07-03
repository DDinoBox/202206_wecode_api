const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// 지점아이디 가져오기
const getBranchId = async (branch_name) => {
  return await prisma.Branch.findMany({
    where: {
      name: branch_name,
    }, 
    select: {
      id: true,
    }
  });
};

// 등록되어 있는 아이디 중복 확인
const getPersonalId = async (personal_id) => {
  return await prisma.Dealer.findMany({});
};

// admin signup
const adminSignup = async (
  branch_id,
  personal_id,
  hashedPassword,
  name,
  level
) => {
  return await prisma.Dealer.create({
		data: {
			personal_id: personal_id,
			password   : hashedPassword,
			name       : name,
			level      : level,
			branches   : {
        connect:{
          id: branch_id
        }
      }
    }
  });
};

module.exports = {
  adminSignup,
  getBranchId,
  getPersonalId
};
