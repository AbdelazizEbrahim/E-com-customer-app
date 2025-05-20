const validateRegister = (req, res, next) => {
  const { name, email, password } = req.body;

  if (!name || !email || !password) {
    return res.status(400).json({ message: "All fields are required" });
  }

  if (!/\S+@\S+\.\S+/.test(email)) {
    return res.status(400).json({ message: "Invalid email format" });
  }

  if (password.length < 6) {
    return res
      .status(400)
      .json({ message: "Password must be at least 6 characters" });
  }

  next();
};

module.exports = { validateRegister };

const validateLogin = (req, res, next) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return res.status(400).json({ message: "Email and password are required" });
  }
  if (!/\S+@\S+\.\S+/.test(email)) {
    return res.status(400).json({ message: "Invalid email format" });
  }
  next();
};

const validateProduct = (req, res, next) => {
  const { name, price, brand, category, images } = req.body;
  if (!name || !price || !brand || !category) {
    return res
      .status(400)
      .json({ message: "Name, price, brand, and category are required" });
  }
  if (!Array.isArray(images) || images.length === 0) {
    return res.status(400).json({ message: "At least one image is required" });
  }
  for (const image of images) {
    if (!image.color || !image.colorCode || !image.image) {
      return res.status(400).json({
        message: "Each image must have color, colorCode, and image URL",
      });
    }
  }
  next();
};

module.exports = { validateRegister, validateLogin, validateProduct };
