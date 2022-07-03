-- CreateTable
CREATE TABLE `users` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NULL,
    `kakao_id` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,

    UNIQUE INDEX `users_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_notifications` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sales_process_id` INTEGER NOT NULL,
    `content` VARCHAR(191) NOT NULL,
    `read` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `user_notifications_sales_process_id_key`(`sales_process_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `car_information` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `owner` VARCHAR(191) NULL,
    `car_name` VARCHAR(191) NULL,
    `trim` VARCHAR(191) NULL,
    `number` VARCHAR(191) NULL,
    `body_shape` VARCHAR(191) NULL,
    `color` VARCHAR(191) NULL,
    `model_year` VARCHAR(191) NULL,
    `first_registration_year` VARCHAR(191) NULL,
    `engine` VARCHAR(191) NULL,
    `transmission` VARCHAR(191) NULL,
    `manufacturer` VARCHAR(191) NULL,
    `factory_price` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `car_information_user_id_key`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `insurance_histories` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `car_information_id` INTEGER NOT NULL,
    `history` LONGTEXT NOT NULL,

    UNIQUE INDEX `insurance_histories_car_information_id_key`(`car_information_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transaction_histories` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `car_information_id` INTEGER NOT NULL,
    `history` LONGTEXT NOT NULL,

    UNIQUE INDEX `transaction_histories_car_information_id_key`(`car_information_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `estimates` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `car_information_id` INTEGER NOT NULL,
    `mileage` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `phone_number` VARCHAR(191) NOT NULL,
    `sunroof` BOOLEAN NOT NULL DEFAULT false,
    `navigation` BOOLEAN NOT NULL DEFAULT false,
    `ventilation_seat` BOOLEAN NOT NULL DEFAULT false,
    `heated_seat` BOOLEAN NOT NULL DEFAULT false,
    `electric_seat` BOOLEAN NOT NULL DEFAULT false,
    `smart_key` BOOLEAN NOT NULL DEFAULT false,
    `leather_seat` BOOLEAN NOT NULL DEFAULT false,
    `electric_folding_mirrort` BOOLEAN NOT NULL DEFAULT false,
    `accident_state` LONGTEXT NULL,
    `spare_key` INTEGER NULL,
    `wheel_scratch` INTEGER NULL,
    `outer_plate_scratch` INTEGER NULL,
    `other_maintenence_repair` LONGTEXT NULL,
    `other_special` LONGTEXT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,

    UNIQUE INDEX `estimates_car_information_id_key`(`car_information_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `estimate_car_images` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `estimate_id` INTEGER NOT NULL,
    `image_info` VARCHAR(191) NOT NULL,
    `image` LONGTEXT NOT NULL,

    UNIQUE INDEX `estimate_car_images_estimate_id_key`(`estimate_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sales_processes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `estimate_id` INTEGER NOT NULL,
    `sales_processes_id` INTEGER NOT NULL,
    `quote_requested` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `dealer_assigned` DATETIME(3) NULL,
    `dealer_consulting` DATETIME(3) NULL,
    `selling_requested` DATETIME(3) NULL,
    `selling_completed` DATETIME(3) NULL,
    `termination` DATETIME(3) NULL,

    UNIQUE INDEX `sales_processes_estimate_id_key`(`estimate_id`),
    UNIQUE INDEX `sales_processes_sales_processes_id_key`(`sales_processes_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dealers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `branch_id` INTEGER NOT NULL,
    `level` VARCHAR(191) NOT NULL,
    `personal_id` VARCHAR(191) NOT NULL,
    `password` LONGTEXT NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,

    UNIQUE INDEX `dealers_branch_id_key`(`branch_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `branches` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `latitude` FLOAT NULL,
    `longitude` FLOAT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `quote_notifications` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `branch_id` INTEGER NOT NULL,
    `sales_process_id` INTEGER NOT NULL,
    `dealer_assigned` BOOLEAN NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `quote_notifications_branch_id_key`(`branch_id`),
    UNIQUE INDEX `quote_notifications_sales_process_id_key`(`sales_process_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user_notifications` ADD CONSTRAINT `user_notifications_sales_process_id_fkey` FOREIGN KEY (`sales_process_id`) REFERENCES `sales_processes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `car_information` ADD CONSTRAINT `car_information_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `insurance_histories` ADD CONSTRAINT `insurance_histories_car_information_id_fkey` FOREIGN KEY (`car_information_id`) REFERENCES `car_information`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transaction_histories` ADD CONSTRAINT `transaction_histories_car_information_id_fkey` FOREIGN KEY (`car_information_id`) REFERENCES `car_information`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `estimates` ADD CONSTRAINT `estimates_car_information_id_fkey` FOREIGN KEY (`car_information_id`) REFERENCES `car_information`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `estimate_car_images` ADD CONSTRAINT `estimate_car_images_estimate_id_fkey` FOREIGN KEY (`estimate_id`) REFERENCES `estimates`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `sales_processes` ADD CONSTRAINT `sales_processes_estimate_id_fkey` FOREIGN KEY (`estimate_id`) REFERENCES `estimates`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `dealers` ADD CONSTRAINT `dealers_branch_id_fkey` FOREIGN KEY (`branch_id`) REFERENCES `branches`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `quote_notifications` ADD CONSTRAINT `quote_notifications_sales_process_id_fkey` FOREIGN KEY (`sales_process_id`) REFERENCES `sales_processes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `quote_notifications` ADD CONSTRAINT `quote_notifications_branch_id_fkey` FOREIGN KEY (`branch_id`) REFERENCES `branches`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
