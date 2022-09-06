import { Module } from '@nestjs/common';
import { CartsModule } from './handlers/carts/carts.module';
import { APP_GUARD } from '@nestjs/core';
import { ApiKeyAuthGuard } from './guards/api-key-auth.guard';
import { ProductsModule } from './handlers/products/products.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [CartsModule, ConfigModule.forRoot(), ProductsModule],
  controllers: [],
  providers: [
    {
      provide: APP_GUARD,
      useClass: ApiKeyAuthGuard,
    },
  ],
})
export class AppModule {}
